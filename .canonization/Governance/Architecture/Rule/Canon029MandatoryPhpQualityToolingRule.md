# Canon029MandatoryPhpQualityToolingRule — PHP Components Require Standard Quality Tooling

## Identity

Canon: `Canon029`
Gating mirror: `Canon029MandatoryPhpQualityToolingRule.php`

## Requirement
Every canonical platform PHP repository declares PHP-CS-Fixer and PHPStan as development dependencies, provides explicit repository-owned configuration for both tools, and exposes reproducible Composer scripts that run formatting checks/fixes and static analysis.

## Required Dependencies
- `friendsofphp/php-cs-fixer` in `composer.json:require-dev`.
- `phpstan/phpstan` in `composer.json:require-dev`.

## Required Configuration
PHP-CS-Fixer configuration must be repository-visible, canonically `.php-cs-fixer.dist.php` or `.php-cs-fixer.php`. PHPStan configuration must be repository-visible through a supported root or quality-tree config such as `phpstan.neon`, `phpstan.neon.dist`, `phpstan.dist.neon`, or `.gating/quality/**/phpstan.neon`.

## Required Execution Contract
Composer scripts must expose a PHP-CS-Fixer check/fix path and a PHPStan analysis path. Script names may differ, but the commands must invoke `php-cs-fixer` and `phpstan` respectively.

## External Inspecting Verification Contour
`Inspecting` is the platform-owned external quality/architecture analysis engine. It is not a Composer/runtime dependency of each target repository and must not be added to a consumer merely to satisfy Canon029.

Autonomous RC verification, CanonScanning/nightly orchestration, and explicit quality-remediation tasks must consume applicable Inspecting evidence for the target repository using an evidence-first contract. A fresh persisted Inspecting report tied to the current repository fingerprint is reusable verification evidence and must not be duplicated by immediately running Inspecting again.

When fresh Inspecting evidence exists and the inspected repository fingerprint has not materially changed, downstream autonomous work reads and uses that evidence as its baseline. A new Inspecting run is required only when applicable evidence is missing or stale, or after relevant repository mutation to verify the resulting state. When an Inspecting RED report contains actionable findings, the task must remediate applicable findings within the target repository boundary and re-run Inspecting after remediation before declaring that inspection front green. Observational findings remain evidence for judgment and are not automatically hard RC blockers unless another applicable canon/gate/policy promotes them.

Absence of a direct source, Composer, or runtime reference from the target repository to `Inspecting` is expected and is not a reason to skip this external verification contour.

## Rationale
Canonization does not duplicate formatter or static-analysis rules. It guarantees that the standard industry tools responsible for those concerns are present, configured, and executable in every PHP repository.

## Guardability
Split ownership. The repository-local portion is hard: Gating validates dev dependencies, discovers supported config files, and inspects Composer scripts for executable PHP-CS-Fixer and PHPStan commands. The external Inspecting contour is orchestration-owned: Console MCP/CanonScanning must execute or consume Inspecting evidence and cannot be inferred from target `composer.json` alone.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "composer.json require-dev/scripts plus supported quality-config path existence"
  extraction: [dev_dependencies, composer_scripts, php_cs_fixer_config_presence, phpstan_config_presence]
  body_read: prohibited
  reasoning: none
  escalation: [nonstandard_repository_owned_tool_config]
  executable_evidence: ["Gating Canon029 findings"]
```
