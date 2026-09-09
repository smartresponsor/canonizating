# SmartResponsor Architecture Canon

This directory is the authoritative non-executable architecture canon for the SmartResponsor platform.

The platform baseline is Symfony 8, PHP 8.4, and the default Symfony `App\\` namespace model. Alternative domain namespace roots are not part of the canon. `src/Domain/` and Port/Adapter/Adaptor taxonomies are not default platform structures.

## Contents

- `Rule/` — normative, self-contained architecture rules.
- `CANONICAL_RULES_JOURNAL.md` — evidence and decision history used while consolidating rules from component repositories.
- `GUARD_MATRIX.md` — mapping from normative rules to executable checks in Gating.

## Authority model

Canonization owns normative meaning. Gating owns executable enforcement. Canonization's local `.gate/` is a self-validation/distributed gate pack and is not a second source of normative architecture rules.

Agent-facing summaries such as root `AGENTS.md` may project the canon for a specific tool or workflow, but must not become an independent competing source of truth.

## Rule identity and mirror contract

Every accepted architecture rule uses a stable `CanonNNN` identity. The semantic name follows that identity and the technical role `Rule` is the final token.

```text
Canonization: Canon003DtoIsExplicitRule.md
Gating:       Canon003DtoIsExplicitRule.php
```

The shared foreign key is `Canon003`; the mirrored semantic name makes human navigation immediate. File paths and repository-relative links are not part of the cross-repository identity contract.

## Canon admission boundary

Canonization does not duplicate stable commodity checks already owned by standard ecosystem tooling. Formatting/style belongs to tools such as PHP-CS-Fixer or PHPCS; analyzable type/code defects belong to PHPStan/Rector-class tooling. A SmartResponsor Canon rule is justified when it defines platform-specific architecture, topology, ownership, lifecycle, or semantic behavior that ordinary tooling cannot determine from language syntax/types alone.
