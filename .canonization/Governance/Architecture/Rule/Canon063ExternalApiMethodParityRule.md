# Canon063ExternalApiMethodParityRule — External API Methods Match Canonical OpenAPI

## Identity

Canon: `Canon063`
Gating mirror: `Canon063ExternalApiMethodParityRule.php`

## Requirement

A first-party external HTTP API keeps its declared runtime HTTP method set mirrored bidirectionally with operations declared by the Canon058-compatible canonical OpenAPI source.

The comparison unit is:

```text
HTTP_METHOD + normalized_path
```

Examples:

```text
GET /api/v1/billing/invoices
POST /api/v1/billing/invoices
DELETE /api/v1/billing/invoices/{id}
```

Each pair is a distinct operation.

## Hard Parity

Both drift directions are non-canonical:

- runtime operation without matching OpenAPI operation;
- OpenAPI operation without matching runtime operation.

A path match does not satisfy this rule when the method differs.

For example, runtime `POST /api/v1/vendor` and OpenAPI `GET /api/v1/vendor` satisfy Canon056 path parity but fail Canon063 method parity.

## Runtime Method Determinism

An ordinary external Symfony API route must declare an explicit bounded method set before it can participate in method parity.

A route such as:

```yaml
path: /api/v1/billing/invoices
```

with no explicit `methods` is non-canonical for Canon063 because Symfony method acceptance is unbounded from the contract perspective. Gating must not assume `GET`.

Canonical route metadata declares the method set explicitly:

```yaml
path: /api/v1/billing/invoices
methods: [GET, POST]
```

The same principle applies to PHP route attributes.

## Grammar-backed Routes

Generic grammar-backed routes such as:

```text
/api/{apiVersion}/{crudPath}
```

must not be expanded by generic Gating logic. Their actual external operation inventory belongs to the grammar owner.

Until a deterministic operation inventory provider is available, Gating reports such surfaces as contextual/provider-needed rather than guessing concrete METHOD + path operations.

## Canonical OpenAPI Source

Canon063 consumes only the source accepted by Canon058 and bound to parity by Canon059.

Generated, published, documentation, legacy, or other OpenAPI artifacts are not eligible denominators.

## Declared Methods

Canon063 compares explicitly declared runtime methods with explicitly declared OpenAPI operation keys.

Framework transport conveniences or implicit handling such as automatic `HEAD` behavior are not inferred as additional contract operations unless they are explicitly declared by the runtime route inventory and the OpenAPI contract.

## Relationship to Canon056

Canon056 owns path parity:

```text
normalized_path
```

Canon063 owns method parity:

```text
HTTP_METHOD + normalized_path
```

The rules are intentionally separate so path completeness and operation completeness cannot mask each other.

## Non-goals

Canon063 does not define:

- response status-code coverage;
- request parameter or body coverage;
- content-type coverage;
- security requirement coverage;
- behavioral/test execution coverage;
- breaking-change compatibility;
- OpenAPI structural/schema validation.

## Guardability

Hard for ordinary external API routes with explicit method sets and a deterministic canonical OpenAPI source. Grammar-backed surfaces remain contextual until their owner supplies an explicit operation inventory provider.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "declared runtime external API methods and canonical OpenAPI operation methods"
  extraction: [runtime_method, runtime_normalized_path, openapi_method, openapi_normalized_path, canonical_openapi_source, operation_inventory_provider]
  body_read: paths_and_methods_only
  reasoning: none
  escalation: [runtime_operation_missing_from_openapi, openapi_operation_missing_from_runtime, unbounded_route_method, grammar_backed_route_without_operation_inventory]
  executable_evidence: ["Gating Canon063 METHOD + path parity findings"]
```
