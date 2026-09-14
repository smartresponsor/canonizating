# Canon033ComposerManifestIdentityParityRule — Development and Production Manifests Share Identity

## Requirement
`composer.json` and `composer.prod.json` describe the same SmartResponsor component identity.

Identity parity covers package `name`, package `type`, PSR-4 autoload identity, PHP platform baseline, and Symfony baseline.

## Allowed Differences
Dependency sets are not required to be identical. Development and production may legitimately differ in `require`, `require-dev`, repositories, scripts, local path dependencies, production-only packages, and other environment-specific resolution details.

## Prohibited Drift
Production may not silently become a differently named package, different component namespace, different bundle/package type, or different PHP/Symfony platform generation.

## Guardability
Hard when both manifests exist. Existence and production repository mode remain owned by Canon024.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "composer.json and composer.prod.json identity fields only"
  extraction: [name, type, psr4_autoload, php_constraint, symfony_constraints]
  body_read: prohibited
  reasoning: none
  escalation: [manifest_parse_failure, multiple_identity_mappings]
  executable_evidence: ["Gating Canon033 findings"]
```

## Rationale
Two manifests are two resolution modes of one component, not two independent package definitions.
