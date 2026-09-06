# Governance

Source-of-truth area for Governance policies/config/docs. No runtime code.

## Architecture canon

The authoritative non-executable SmartResponsor architecture canon lives under
`Architecture/`.

- `Architecture/Rule/` contains normative rules.
- `Architecture/CANONICAL_RULES_JOURNAL.md` records provenance, consolidation,
  deduplication, and accepted decisions.
- `Architecture/GUARD_MATRIX.md` maps normative rules to executable or semantic
  enforcement opportunities.

`Gating` is the executable enforcement layer for this canon. Executable checks
do not replace or redefine the normative meaning recorded here.
