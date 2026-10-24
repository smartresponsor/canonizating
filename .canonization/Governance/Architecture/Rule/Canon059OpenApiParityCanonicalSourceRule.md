# Canon059OpenApiParityCanonicalSourceRule — OpenAPI Parity Consumes the Canonical Source

## Identity

Canon: `Canon059`
Gating mirror: `Canon059OpenApiParityCanonicalSourceRule.php`

## Requirement

External API / OpenAPI parity checks must consume only the Canon058 canonical OpenAPI source.

A parity rule must not silently compare runtime routes against generated, published, documentation, legacy, or root `api/` OpenAPI artifacts.

The canonical denominator is the single current OpenAPI source accepted by Canon058:

```text
config/openapi/<subject>_openapi.yaml
```

or an explicitly declared Canon058-compatible profile path such as:

```yaml
canonical_openapi_path: config/openapi/<subject>_openapi.yaml
```

## Rationale

Parity is meaningful only when the two sides are authoritative representations of the same contract. Comparing runtime routes against `public/openapi.json`, `var/openapi.json`, `docs/openapi.yaml`, `legacy/openapi.yaml`, or root `api/openapi.yaml` can hide drift by using generated, stale, rendered, or historical artifacts.

Canon059 binds Canon056 to Canon058. Canon058 identifies the source of truth; Canon056 compares runtime API paths and method-level evidence against that source.

## Non-canonical

The following are non-canonical parity denominators:

```text
public/openapi.json
var/openapi/openapi.json
docs/openapi.yaml
legacy/openapi.yaml
api/openapi.yaml
config/openapi/openapi.yaml
```

`config/openapi/openapi.yaml` is invalid because it does not satisfy the Canon038 subject-prefix naming contour.

## Guardability

Hard when external runtime API routes and OpenAPI-looking files are present. If no external runtime API route exists, the rule is not applicable. If no OpenAPI-looking file exists, parity source selection is not applicable and Canon056 owns the missing-contract failure when parity is actually required.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "external runtime API routes plus OpenAPI-looking artifacts and Canon058-compatible canonical source candidates"
  extraction: [runtime_api_route_paths, openapi_artifact_paths, canonical_openapi_source_candidates, declared_canonical_openapi_path]
  body_read: candidates_only
  reasoning: none
  escalation: [openapi_artifact_without_canonical_source, multiple_canonical_sources_without_declaration, parity_against_generated_or_published_artifact]
  executable_evidence: ["Gating Canon059 canonical parity source findings"]
```
