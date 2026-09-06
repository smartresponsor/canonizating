# Canon010ArchitectureMigrationCompletenessRule — Architecture Migration Must Be Complete Across the Repository

## Identity

Canon: `Canon010`
Gating mirror: `Canon010ArchitectureMigrationCompletenessRule.php`

## Requirement
An architecture rename, move, taxonomy change, or dependency migration is not complete when only production PHP is updated. Synchronize every surface encoding the old architecture: tests, Symfony DI/config, routes, guards, docs, namespace references, fixtures, tools, templates, serializer metadata, and other integration surfaces as applicable. Unit/Integration/Functional test trees should mirror current production topology as far as their test role permits.

## Prohibited
Do not leave guards on deleted classes, tests on obsolete namespaces, docs recommending superseded patterns, stale aliases/wrappers after callers migrate, or cross-repository consumers/bridges on the old API after an owner rename.

## Rationale
Architecture is encoded outside `src/`. Partial migration leaves two competing models and teaches obsolete structure to tools and engineers.

## Exceptions
Explicit compatibility surfaces may remain only when compatibility is an active requirement with a defined removal lifecycle. Generated/cache/dependency noise is not part of the migration surface and should not be committed merely to reflect a rename.

## Guardability
Composite: many subchecks are hard, while semantic completion across consumers may require cross-repository review.
