# Canon015NoToolingArchitectureLeakRule — Tooling Must Not Become a Shadow Runtime Architecture

## Identity

Canon: `Canon015`
Gating mirror: `Canon015NoToolingArchitectureLeakRule.php`

## Requirement
Temporary migration, maintenance, and repository tooling may live outside `src/`, but stable reusable runtime/business behavior belongs in the corresponding typed `src/<Role>/...` tree.

## Prohibited
Do not keep persistent parsers, resolvers, repositories, policies, domain/application services, or other reusable runtime classes under `tool/`, `tools/`, `script/`, or equivalent utility roots as an alternative architecture.

## Rationale
Tool roots have weaker lifecycle and dependency contracts. Allowing stable application logic to accumulate there creates an ungoverned second source tree.

## Exceptions
One-shot migration helpers, repository automation, build/release scripts, diagnostics, generators, and maintenance entry scripts may remain tooling when their implementation is genuinely tooling-specific.

## Guardability
Hard for namespaced reusable PHP types in tooling roots; semantic for deciding whether a tool has become stable runtime behavior.
