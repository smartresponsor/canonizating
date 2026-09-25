# Canon025ComponentDualRuntimeModeRule — Components Support Standalone and Bundle Modes

## Identity

Canon: `Canon025`
Gating mirror: `Canon025ComponentDualRuntimeModeRule.php`

## Requirement
Platform Symfony components are self-bootable standalone applications for container build, verification, tests, and debugging, while also remaining reusable Symfony bundles for composition into a Host application.

## Prohibited
Do not design a component so that it can only boot through the Host, and do not make its standalone bootstrap the only supported integration form.

## Rationale
The dual mode keeps each component independently testable and container-verifiable without sacrificing bundle composition in the platform Host.

## Expected Surfaces
Canonical components expose standalone Symfony boot surfaces such as `bin/console` and `config/bundles.php`, plus a component bundle class or equivalent Symfony bundle declaration.

## Guardability
Hard for expected boot/bundle surfaces where the repository is recognized as a canonical platform Symfony component.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "standalone boot surfaces and reusable bundle declaration/registration surfaces"
  extraction: [bin_console_presence, bundles_config_presence, kernel_surface, bundle_declarations]
  body_read: candidates_only
  reasoning: none
  escalation: [custom_kernel_or_bundle_bootstrap]
  executable_evidence: ["Gating Canon025 findings"]
```
