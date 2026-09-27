# Canon060OpenApiVersionPrefixRule — OpenAPI Paths Use /api/vN Prefix

## Identity

Canon: `Canon060`
Gating mirror: `Canon060OpenApiVersionPrefixRule.php`

## Requirement

Versioned paths in the canonical OpenAPI source must place the version token immediately after `/api`.

Canonical path shape:

```text
/api/vN/...
```

The version token must match:

```text
^v[1-9][0-9]?$ 
```

Therefore `v1` through `v99` are canonical. `v0`, leading-zero tokens, three-digit tokens, numeric-only tokens, and prose tokens are non-canonical.

## Good Examples

```text
/api/v1/billing/invoices
/api/v1/catalog/categories
/api/v10/shipping/carriers
```

## Bad Examples

```text
/api/billing/v1/invoices
/api/vendor/v1
/api/1/vendor
/api/version1/vendor
/api/v01/vendor
/api/v100/vendor
```

## Relationship to Canon057

Canon057 owns the same version-prefix placement rule on runtime Symfony routes.

Canon060 owns the OpenAPI contract side. The two rules keep runtime route grammar and published contract grammar aligned without depending on request/response schemas, examples, or OpenAPI validation tooling.

## Compatibility

Canon060 does not automatically fail unversioned `/api/...` OpenAPI paths. Existing unversioned paths are compatibility or migration surfaces governed by lifecycle evidence. New versioned OpenAPI paths must use `/api/vN/...`.

## Non-goals

Canon060 does not define:

- canonical OpenAPI source location;
- runtime/OpenAPI path parity;
- request/response schemas;
- status-code coverage;
- breaking-change policy;
- OpenAPI document structural validity.

## Guardability

Hard when a Canon058-compatible canonical OpenAPI source is available and contains version-looking `/api` paths.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "paths declared in the Canon058-compatible canonical OpenAPI source"
  extraction: [canonical_openapi_source, openapi_path, api_segment_index, version_segment, version_segment_position]
  body_read: paths_only
  reasoning: none
  escalation: [version_token_not_after_api, invalid_openapi_version_token]
  executable_evidence: ["Gating Canon060 OpenAPI version-prefix findings"]
```
