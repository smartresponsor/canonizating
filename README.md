# Canonization

Owner-side canonical tooling and policy pack for SmartResponsor repositories.

## Repository contract

The repository root is intentionally small. Canonization content is organized in dot-folders, primarily:

- `.canonization/` — canonization metadata and manifests
- `.commanding/` — command helpers
- `.consuming/` — consumer/update helpers
- `.gate/` — executable contracts, linting, policy and quality checks
- `.intelligence/` — automation/intelligence helpers
- `.release/`, `.deploy/`, `.smoke/` — release/runtime support

Standard repository files such as `.editorconfig`, `.gitattributes`, `.gitignore`, `AGENTS.md`, `composer.json`, `composer.lock`, `MANIFEST.json`, and `README.md` may live at root. `AGENTS.md` is an agent-facing projection of the canon; normative meaning remains in `.canonization/Governance/Architecture/Rule/`.

## Gate

Run the canonical gate from the repository root:

- Windows: `pwsh -ExecutionPolicy Bypass -File .gate/gate.ps1 .`
- Linux/macOS: `bash .gate/gate.sh .`

The gate runs root-contract checks, gitignore checks, naming/lint checks, layer-mirror checks, and optional quality checks.

Set `QUALITY=1` to include the quality stage when invoking the shell gate.

## Canonical locations

- Executable gate entrypoints: `.gate/gate.ps1`, `.gate/gate.sh`
- Contracts: `.gate/contract/**`
- Linting: `.gate/linting/**`
- Policies: `.gate/policy/**`
- Quality checks: `.gate/quality/**`
- Distribution manifest: `.gate/MANIFEST.json`

Do not duplicate canonical rules in component-specific prompts. Repository architecture rules belong in the gate/policy system and are evolved there.
