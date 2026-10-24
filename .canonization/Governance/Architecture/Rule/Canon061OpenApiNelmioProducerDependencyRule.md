# Canon061OpenApiNelmioProducerDependencyRule — OpenAPI Owners Declare Nelmio API Doc Bundle

## Identity

Canon: `Canon061`
Gating mirror: `Canon061OpenApiNelmioProducerDependencyRule.php`

## Requirement

A Symfony repository that owns a first-party OpenAPI contract declares `nelmio/api-doc-bundle` as a direct runtime Composer dependency.

This rule is conditional. `nelmio/api-doc-bundle` is not part of the universal standalone application baseline in Canon022. It is required only when the repository exposes an OpenAPI ownership/configuration surface, such as:

```text
config/openapi/<subject>_openapi.yaml
config/openapi/*_openapi.yaml
```

or an explicitly declared Canon058-compatible profile path:

```yaml
canonical_openapi_path: config/openapi/<subject>_openapi.yaml
```

## Rationale

EasyAdmin is a universal standalone back-office/admin surface in the platform baseline. NelmioApiDocBundle is different: it is the standard Symfony OpenAPI documentation producer surface, but it is only meaningful for repositories that actually own OpenAPI contracts.

Therefore Canon061 binds the OpenAPI owner surface to a standard producer dependency without forcing repositories with no OpenAPI responsibility to install API-documentation tooling.

## Direct Dependency

The dependency must appear directly in `composer.json:require`.

Transitive availability through another package is not canonical because OpenAPI generation and route-to-contract wiring are repository-owned responsibilities.

## Applicability

The rule applies when at least one OpenAPI ownership/configuration indicator exists.

It does not require repositories without OpenAPI sources, OpenAPI config, or declared canonical OpenAPI profile path to install NelmioApiDocBundle.

## Non-goals

Canon061 does not define:

- OpenAPI source location;
- OpenAPI path/runtime parity;
- OpenAPI path version grammar;
- YAML/OpenAPI document structural validation;
- rendered documentation publication;
- Nelmio configuration completeness.

Those concerns belong to adjacent rules or tooling.

## Guardability

Hard when `composer.json` and OpenAPI ownership/configuration indicators are available.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "composer.json plus OpenAPI ownership/configuration indicators"
  extraction: [composer_require_packages, canonical_openapi_path, config_openapi_files]
  body_read: candidates_only
  reasoning: none
  escalation: [openapi_owner_missing_nelmio_api_doc_bundle]
  executable_evidence: ["Gating Canon061 OpenAPI Nelmio producer dependency findings"]
```
