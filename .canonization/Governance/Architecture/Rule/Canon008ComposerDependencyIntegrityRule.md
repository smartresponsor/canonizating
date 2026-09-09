# Canon008ComposerDependencyIntegrityRule — Foreign Component Usage Requires Explicit Composer Dependency

## Identity

Canon: `Canon008`
Gating mirror: `Canon008ComposerDependencyIntegrityRule.php`

## Requirement
If PHP code imports or references a namespace owned by another component repository, the corresponding package must be declared explicitly in Composer for the runtime scope in which that code is loaded. The PHP dependency graph and Composer package graph must agree.

## Prohibited
Do not use foreign namespaces without a package dependency, rely on a neighboring workspace folder as an undeclared dependency, create mandatory compile-time imports for optional integrations, or place a production dependency only in dev scope.

## Rationale
Package metadata must describe the same coupling that exists in code so components remain reproducible and independently installable.

## Good example
Production PHP imports a Cruding namespace and `composer.json` declares the Cruding package in `require`.

## Bad example
`use App\\OtherComponent\\Service\\FooService;` with no Composer package providing that namespace.

## Exceptions
Dev-only tests/tools may use dev dependencies when the referenced code is not loaded in production. Optional integrations must remain genuinely optional.

## Guardability
Hard when Gating has a namespace-to-package ownership map/profile.
