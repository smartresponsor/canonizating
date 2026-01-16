#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
# gate fix proposal (NDJSON) -> .report/gate-fix-proposal.ndjson
# policy sources:
#   .gate/policy/acceptable/daily-proposal.yml  (always)
#   .gate/policy/acceptable/fail-proposal.yml   (on failures)
# output:
#   .report/gate-fix-proposal.ndjson
# ------------------------------------------------------------

GATE_PROPOSAL_FILE="${GATE_PROPOSAL_FILE:-.report/gate-fix-proposal.ndjson}"

gate_proposal_init() {
  mkdir -p ".report"
  : > "$GATE_PROPOSAL_FILE"
}

gate_proposal_add() {
  # $1 = json line
  mkdir -p ".report"
  printf "%s\n" "$1" >> "$GATE_PROPOSAL_FILE"
}

gate_proposal_load_yml() {
  local yml_path="$1"
  if [[ -f "$yml_path" ]]; then
    mkdir -p ".report"
    python3 - "$yml_path" <<'PY' >> "$GATE_PROPOSAL_FILE"
import sys, json
try:
    import yaml
except Exception:
    raise SystemExit(0)

p = sys.argv[1]
with open(p, "r", encoding="utf-8", errors="ignore") as f:
    data = yaml.safe_load(f) or {}
for item in (data.get("proposal") or []):
    if not isinstance(item, dict):
        continue
    sys.stdout.write(json.dumps(item, ensure_ascii=False) + "\n")
PY
  fi
}

gate_json_report_print() {
  local text="$1"
  python3 - "$text" <<'PY'
import json, sys
text = sys.argv[1]
obj = {
  "op": "report.print",
  "level": "warn",
  "text": text,
  "note": "gate hint"
}
print(json.dumps(obj, ensure_ascii=False))
PY
}

gate_proposal_print_summary() {
  if [[ -f "$GATE_PROPOSAL_FILE" ]]; then
    echo "[gate] proposal file: $GATE_PROPOSAL_FILE"
    echo "[gate] proposal entries:"
    cat "$GATE_PROPOSAL_FILE" || true
  else
    echo "[gate] proposal file: (none)"
  fi
}

REPO_ROOT="${1:-$(pwd)}"

# start fresh proposal file on every run
gate_proposal_init

# load daily baseline proposals (policy only)
gate_proposal_load_yml "$REPO_ROOT/.gate/policy/acceptable/daily-proposal.yml"

QUALITY="${QUALITY:-0}"

MODE="consumer"
if [[ "${GITHUB_REPOSITORY:-}" == */canonization ]]; then
  MODE="canon"
fi

echo "[gate] repo=${GITHUB_REPOSITORY:-local} mode=$MODE root=$REPO_ROOT"


# Contract
# root-contract => ONLY for canonization repo
if [[ "$MODE" == "canon" ]]; then
  bash "$REPO_ROOT/.gate/contract/sh/root-contract-check.sh" "$REPO_ROOT"
else
  echo "[gate] skip root-contract-check (consumer repo)"
fi

# gitignore template check => OK for everyone
if ! bash "$REPO_ROOT/.gate/contract/sh/gitignore-template-check.sh" "$REPO_ROOT"; then
  gate_proposal_load_yml "$REPO_ROOT/.gate/policy/acceptable/fail-proposal.yml"
  gate_proposal_add "$(gate_json_report_print 'Suggested: apply fail-proposal ops for current gate failure')"
  gate_proposal_print_summary
  exit 3
fi

# Linting (fast checks) - JS checks require node
if command -v node >/dev/null 2>&1; then
  node "$REPO_ROOT/.gate/linting/js/no-plural-check.js" "$REPO_ROOT"
  node "$REPO_ROOT/.gate/linting/js/layer-mirror-check.js" "$REPO_ROOT"
  node "$REPO_ROOT/.gate/linting/js/doc-name-check.js" "$REPO_ROOT"
  node "$REPO_ROOT/.gate/linting/js/archive-name-check.js" "$REPO_ROOT"
else
  echo "node not found, skipping JS linting checks"
fi

bash "$REPO_ROOT/.gate/linting/sh/copyright-header-check.sh" "$REPO_ROOT"
bash "$REPO_ROOT/.gate/linting/sh/layer-mirror-check.sh" "$REPO_ROOT"
bash "$REPO_ROOT/.gate/linting/sh/doc-name-check.sh" "$REPO_ROOT"
bash "$REPO_ROOT/.gate/linting/sh/archive-flat-root-check.sh" "$REPO_ROOT"

if [[ "$QUALITY" == "1" ]]; then
  bash "$REPO_ROOT/.gate/quality/sh/quality-run.sh" "$REPO_ROOT"
fi

gate_proposal_print_summary

echo "Gate OK"
