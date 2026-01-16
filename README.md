canon-clean

Cleaned, structured snapshot of the Canon domain aligned with SmartResponsor canon + industrial rules.

Quick start

- Windows: `pwsh -ExecutionPolicy Bypass -File canon.ps1 gate`
- Linux/mac: `./canon.sh gate`

Main commands (entrypoints)

- `./canon.ps1 gate|validate|strict|matrix|test|pack|verify|fix|overlay`
- `./canon.sh gate|validate|strict|matrix|test|pack|verify|fix|overlay`

Where the tools live (separated by runtime)

- Node core checks: `tool/node/*.js`
- PowerShell wrappers: `tool/ps1/*.ps1`
- Bash wrappers: `tool/sh/*.sh`

Examples

- Validate schema: `node tool/node/canon-validate.js --root .`
- Strict invariants: `node tool/node/canon-strict.js --root .`
- Matrix completeness: `node tool/node/canon-matrix-check.js --root .`
- Doc index check: `node tool/node/canon-doc-index.js --root . --check`
- Safe fix plan: `pwsh tool/ps1/run-canon-fix.ps1 -Root . -DryRun`
- Apply overlay to a target repo:
    - Windows: `pwsh tool/ps1/run-canon-overlay-apply.ps1 -Target C:\path\to\repo -Apply`
    - Linux/mac: `bash tool/sh/run-canon-overlay-apply.sh --target /path/to/repo --apply`

Notes

- Singular naming is enforced for custom folders (checker, lint, contract, event). Reserved ecosystem paths stay
  unchanged.
- Industrial rules live in `industrial-canon/**`.
- Owner rules + consumer overlay live in `owner-canon/**`.
- CI: `.github/workflows/canon.yml` runs `canon gate` on push/PR.


Root contract:
- Root contains only dot-folders + .gitignore/MANIFEST.json/README.md
- .gitignore is the consumer template

Gate:
- Run .gate/gate.ps1 (PowerShell) or .gate/gate.sh
