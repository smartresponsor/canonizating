# Canon025ComponentDualRuntimeModeRule — Components Support Standalone and Bundle Modes

## Identity

Canon: `Canon025`
Gating mirror: `Canon025ComponentDualRuntimeModeRule.php`

## Requirement
SmartResponsor Symfony components are self-bootable standalone applications for container build, verification, tests, and debugging, while also remaining reusable Symfony bundles for composition into a Host application.

## Prohibited
Do not design a component so that it can only boot through the Host, and do not make its standalone bootstrap the only supported integration form.

## Rationale
The dual mode keeps each component independently testable and container-verifiable without sacrificing bundle composition in the platform Host.

## Expected Surfaces
Canonical components expose standalone Symfony boot surfaces such as `bin/console` and `config/bundles.php`, plus a component bundle class or equivalent Symfony bundle declaration.

## Guardability
Hard for expected boot/bundle surfaces where the repository is recognized as a canonical SmartResponsor Symfony component.
