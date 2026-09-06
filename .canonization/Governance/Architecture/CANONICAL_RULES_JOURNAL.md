# Canonical Rules Journal

This journal records how recurring architecture patterns are consolidated into the SmartResponsor canon. The normative wording itself lives in `Rule/`.

## 2026-09-05 — First consolidated architecture batch

Status: accepted for materialization.

Evidence was consolidated from repeated component-repository reviews including Faceting, Facting, Casing, Complying, Cruding, and related SmartResponsor components. The batch also reconciles existing local Canonization guidance with newer cross-repository findings.

Materialized rules: Canon000 through Canon010, with `Rule` as the terminal technical-role token on both Canonization and Gating sides.

Important consolidation decisions:

- `Contract/` is not globally forbidden, but may not be used as a generic dumping ground when a clearer typed interface role exists.
- `Entity/<Component>/` is the only currently accepted early component-folder depth exception because Doctrine mappings, entity managers, aliases, and multiple DB connections can require it.
- Component names ending in `-ing` are not mechanically stemmed. Platform vocabulary controls the PHP subject prefix.
- `Gating` is executable enforcement of the canon, not a competing normative source.
- Historical Federation/Orchestration sketch archives may provide evidence but do not override current normative rules.

## 2026-09-05 — First batch executable debt closure

Canon000 through Canon010 now have mirrored executable PHP rules in Gating under `src/Rule/Canon/`. Gating also has `CanonRuleMirrorRule`, which verifies that local sibling Canonization rule documents have matching `CanonNNN<SemanticName>Rule.php` implementations.

Validation completed successfully: changed-PHP lint, calibration tests, PHPStan, and the full Gating gate all pass.

Profile-dependent semantic rules intentionally return `skipped` when their required vocabulary, dependency, boundary, or migration inputs are not declared rather than guessing.

Closing the first batch also exposed and corrected two existing Gating topology violations: `RoutePolicy` moved into the `Policy/Route` role tree and `GatingRunner` into the `Runner` role tree.
