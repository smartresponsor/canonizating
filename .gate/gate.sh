#!/usr/bin/env bash
set -Eeuo pipefail

REPO_ROOT="${1:-.}"
REPO_ROOT="$(cd "$REPO_ROOT" && pwd)"

MODE="${GATE_MODE:-}"
if [[ -z "$MODE" ]]; then
  if [[ "${GITHUB_REPOSITORY:-}" == *"/canonization" ]]; then
    MODE="canon"
  else
    MODE="consumer"
  fi
fi

GATE_PROPOSAL_FILE="${GATE_PROPOSAL_FILE:-$REPO_ROOT/.report/gate-fix-proposal.ndjson}"
GATE_STEP="init"

gate_proposal_init() {
  mkdir -p "$REPO_ROOT/.report"
  : > "$GATE_PROPOSAL_FILE"
}

gate_proposal_add_json() {
  printf "%s\n" "$1" >> "$GATE_PROPOSAL_FILE"
}

gate_proposal_add_agent_required() {
  local prompt="$1"
  python3 - "$prompt" <<'PY' >> "$GATE_PROPOSAL_FILE"
import json, sys
prompt = sys.argv[1]
obj = {"op":"agent.required","level":"error","scope":["repo"],"prompt":prompt,"note":"needs reasoning"}
print(json.dumps(obj, ensure_ascii=False))
PY
}

gate_proposal_print_summary() {
  echo "[gate] proposal file: ${GATE_PROPOSAL_FILE#$REPO_ROOT/}"
  echo "[gate] proposal entries:"
  if [[ -f "$GATE_PROPOSAL_FILE" ]]; then
    cat "$GATE_PROPOSAL_FILE" || true
  fi
}

# Minimal YAML -> NDJSON loader (no external deps)
gate_policy_apply_yml() {
  local yml="$1"
  [[ -f "$yml" ]] || return 0

  python3 - "$yml" <<'PY' >> "$GATE_PROPOSAL_FILE"
import json, sys, re
p = sys.argv[1]
txt = open(p, "r", encoding="utf-8").read().splitlines()

# Try PyYAML if present
try:
  import yaml  # type: ignore
  data = yaml.safe_load("\n".join(txt)) or {}
  items = data.get("proposal", []) or []
  for it in items:
    if isinstance(it, dict):
      print(json.dumps(it, ensure_ascii=False))
  raise SystemExit(0)
except Exception:
  pass

items = []
cur = None
i = 0

def strip_quotes(v: str) -> str:
  v = v.strip()
  if (v.startswith('"') and v.endswith('"')) or (v.startswith("'") and v.endswith("'")):
    return v[1:-1]
  return v

while i < len(txt):
  line = txt[i].rstrip("\n")
  if re.match(r'^\s*proposal\s*:\s*$', line):
    i += 1
    continue

  m = re.match(r'^\s*-\s+op\s*:\s*(.+)\s*$', line)
  if m:
    if cur:
      items.append(cur)
    cur = {"op": strip_quotes(m.group(1))}
    i += 1
    continue

  if cur is None:
    i += 1
    continue

  m = re.match(r'^\s{2,}([a-zA-Z0-9_]+)\s*:\s*(.*)\s*$', line)
  if m:
    key = m.group(1)
    rest = m.group(2).rstrip()

    # block scalars
    if rest in ("|", ">"):
      block = []
      i += 1
      while i < len(txt):
        nl = txt[i]
        if re.match(r'^\s{6,}', nl):
          block.append(nl.strip())
          i += 1
          continue
        break
      cur[key] = "\n".join(block).rstrip() + ("\n" if rest == "|" and block else "")
      continue

    # array keys: lines / scope
    if rest == "" and key in ("lines", "scope"):
      arr = []
      i += 1
      while i < len(txt):
        nl = txt[i]
        mm = re.match(r'^\s{6,}-\s*(.+)\s*$', nl)
        if not mm:
          break
        arr.append(strip_quotes(mm.group(1)))
        i += 1
      cur[key] = arr
      continue

    # inline scalar
    cur[key] = strip_quotes(rest)
    i += 1
    continue

  i += 1

if cur:
  items.append(cur)

for it in items:
  print(json.dumps(it, ensure_ascii=False))
PY
}

# Back-compat alias (older scripts may call this)
gate_proposal_load_yml() { gate_policy_apply_yml "$1"; }

gate_fail() {
  local code="${1:-2}"
  local step="${2:-unknown}"
  echo "[gate] FAIL step=$step code=$code"
  gate_policy_apply_yml "$REPO_ROOT/.gate/policy/acceptable/fail-proposal.yml" || true
  if [[ -f "$REPO_ROOT/.report/gate-flag-root-contract.fail" ]]; then
    gate_policy_apply_yml "$REPO_ROOT/.gate/policy/acceptable/root-contract-fail-proposal.yml" || true
  fi
  gate_proposal_add_agent_required "Step failed: $step. Review logs and apply proposals; if not enough, perform targeted fixes."
  gate_proposal_print_summary
  exit "$code"
}

on_err() {
  local code="$?"
  gate_fail "$code" "$GATE_STEP"
}
trap on_err ERR

gate_proposal_init

echo "[gate] repo=${GITHUB_REPOSITORY:-local} mode=$MODE root=${REPO_ROOT#$PWD/}"

# Always load daily policy if present
gate_policy_apply_yml "$REPO_ROOT/.gate/policy/acceptable/daily-proposal.yml" || true

# Contract: root contract check only in canon mode
GATE_STEP="root-contract-check"
if [[ "$MODE" == "canon" ]]; then
  bash "$REPO_ROOT/.gate/contract/sh/root-contract-check.sh" "$REPO_ROOT"
else
  echo "[gate] skip root-contract-check (consumer repo)"
fi

# gitignore template check for everyone
GATE_STEP="gitignore-template-check"
bash "$REPO_ROOT/.gate/contract/sh/gitignore-template-check.sh" "$REPO_ROOT"

# Linting / checks
if command -v node >/dev/null 2>&1; then
  GATE_STEP="no-plural-check"
  node "$REPO_ROOT/.gate/linting/js/no-plural-check.js" "$REPO_ROOT"

  GATE_STEP="layer-mirror-check"
  node "$REPO_ROOT/.gate/linting/js/layer-mirror-check.js" "$REPO_ROOT"

  GATE_STEP="doc-name-check"
  node "$REPO_ROOT/.gate/linting/js/doc-name-check.js" "$REPO_ROOT"

  GATE_STEP="archive-name-check"
  node "$REPO_ROOT/.gate/linting/js/archive-name-check.js" "$REPO_ROOT"
else
  echo "[gate] node not found, skipping JS checks"
fi

echo "[gate] OK"
gate_proposal_print_summary
exit 0
