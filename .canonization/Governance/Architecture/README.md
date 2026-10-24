# Platform Architecture Canon

This directory is the authoritative non-executable architecture canon for the multi-domain SaaS platform.

The platform baseline is Symfony 8 and PHP 8.4. `App\\` is the platform namespace root; canonical component code is scoped beneath it as `App\\<ComponentToken>\\...`, where `<ComponentToken>` is the component identity from the first token of `composer.json:name` (for example, `ordering/order` maps to `App\\Ordering\\...`). Bare `App\\...` component code is not the component identity model, except for framework bootstrap types explicitly exempted by the canon. Alternative domain namespace roots are not part of the canon. `src/Domain/` and Port/Adapter/Adaptor taxonomies are not default platform structures.

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

Canonization does not duplicate stable commodity checks already owned by standard ecosystem tooling. Formatting/style belongs to tools such as PHP-CS-Fixer or PHPCS; analyzable type/code defects belong to PHPStan/Rector-class tooling. A platform Canon rule is justified when it defines platform-specific architecture, topology, ownership, lifecycle, or semantic behavior that ordinary tooling cannot determine from language syntax/types alone.

## Evidence and read contour contract

Every Canon rule carries an inline `Evidence Contract`. It is normative execution guidance for repository-reading automation and is part of the rule rather than a second registry.

The contract separates concerns that must not be conflated:

- **coverage** — the complete repository population that must be checked so the rule cannot become false-green;
- **extraction** — the minimum facts that may be deterministically extracted from that population;
- **body_read** — whether full artifact bodies may be exposed to semantic agent/LLM reading (`prohibited`, `candidates_only`, or a rule-specific targeted condition); deterministic parsers may still read bytes needed to extract the explicitly declared facts;
- **reasoning** — whether semantic agent/LLM reasoning is permitted (`none` or `candidates_only` unless the rule explicitly says otherwise);
- **escalation** — concrete evidence that invalidates the cheap contour and permits broader reading;
- **executable_evidence** — deterministic gate/tool output that should replace semantic reasoning when available.

Full coverage does not imply full semantic reading. Repository-wide deterministic traversal is valid when the rule needs complete population coverage, but automation must extract only the fields named by the rule and must not broaden the read contour merely "just in case".

`body_read: prohibited` is a hard prohibition for ordinary evaluation of that rule. `body_read: candidates_only` permits reading only artifacts surfaced by the extraction/gate stage. Semantic reasoning must not be performed when `reasoning: none`.

Automation may broaden beyond the declared contour only after observing a rule-specific escalation condition. Parse failure, ambiguous ownership, unknown extension points, custom source roots/bootstrap, cross-component call-chain dependence, or another explicit escalation signal may justify broader reading; repository familiarity or uncertainty alone does not.

When executable evidence is declared, applicability must be established cheaply first, then the executable evidence should be run. Semantic inspection follows only when that evidence fails, is unavailable, or is explicitly classified as ambiguous by the rule.
