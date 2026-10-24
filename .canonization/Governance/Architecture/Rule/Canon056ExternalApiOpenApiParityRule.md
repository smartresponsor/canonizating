# Canon056ExternalApiOpenApiParityRule — External HTTP API Surface Matches OpenAPI

## Identity

Canon: `Canon056`
Gating mirror: `Canon056ExternalApiOpenApiParityRule.php`

## Requirement

A canonical Symfony application that exposes a first-party external HTTP API keeps its runtime external API path surface mirrored by its canonical OpenAPI contract.

The first hard comparison unit is the normalized path:

```text
normalized_path
```

For example, `/api/v1/billing/invoices` is one external API path shape. Canon056 is path-only. Method-level operation parity is owned by Canon063 and is not part of this rule's denominator.

Request/response schemas, status-code coverage, parameter-value coverage, behavioral coverage, and test adequacy are outside this Canon.

Generic delivery routes whose path parameter carries an internal grammar, such as Cruding-style `/api/{crudPath}` or tokenized catch-all routing, must not be treated as a single ordinary OpenAPI operation merely because Symfony exposes one route. Such routes require a deterministic operation inventory provider that expands or declares the actual external operations produced by the grammar. If no such provider exists, Gating reports the surface as ambiguous instead of passing or failing by guessing.

## Applicability

This rule applies when the repository exposes one or more first-party external HTTP API routes through Symfony routing metadata/configuration, normally under the external `/api/` surface.

A repository with no external HTTP API surface is not required to publish OpenAPI solely to satisfy this rule and is reported as not applicable.

Administrative UI routes, internal framework/bootstrap routes, observability-only routes, and other non-external surfaces are outside the denominator unless the repository explicitly publishes them as part of its external API contract.

A generic route is eligible only through its resolved external operation inventory, not through its catch-all Symfony path alone. The inventory provider must be owned by the capability that owns the grammar. For Cruding, CRUD route grammar, reserved operation tokens, resource-path depth, identity-position rules, and API method semantics remain Cruding-owned and must not be reinterpreted by the generic OpenAPI parity rule.

## Parity

For every eligible Symfony external API path there must be a matching path in the canonical OpenAPI document.

For every external API path in the canonical OpenAPI document there must be a matching eligible Symfony runtime path.

Therefore both hard drift directions are non-canonical:

- runtime path without OpenAPI path: undocumented external API surface;
- OpenAPI path without runtime path: stale/orphan contract surface.

Method-level parity is deliberately excluded from Canon056. Canon063 owns bidirectional hard parity of `HTTP_METHOD + normalized_path` once method inventories are deterministic.

## Canonical OpenAPI document

Canon056 consumes the canonical source selected by Canon058/Canon059. OpenAPI producer ownership and the required Nelmio dependency are governed separately by Canon061; Canon056 does not redefine producer tooling.

When multiple OpenAPI artifacts exist, compatibility, legacy, generated publication copies, or historical specifications must not be silently merged into the denominator. The canonical current contract must be deterministically identifiable by repository configuration/profile or by an unambiguous producer contract.

## Reporting

Gating reports explicit inventories rather than an opaque percentage.

The report must distinguish at least:

- runtime external paths;
- canonical OpenAPI paths;
- runtime paths missing from OpenAPI;
- OpenAPI paths missing from runtime;
- grammar-backed surfaces that require an operation inventory provider;
- operations that cannot be compared deterministically.

The purpose of the report is to provide deterministic architectural evidence to follow-up chat/agent review. Canon056 does not decide how deeply each operation must later be tested or which additional request/response variants deserve coverage.

## Non-goals

Canon056 does not define:

- API test coverage thresholds;
- response/status-code coverage;
- request parameter coverage;
- security/negative-test coverage;
- API breaking-change policy;
- URL version-segment placement;
- whether an otherwise unversioned API must introduce a version segment.

Those concerns require independent evidence and must not be inferred from operation parity.

## Guardability

Hard when both the eligible Symfony external route inventory and the canonical OpenAPI operation inventory are deterministically available. For grammar-backed routes, this also requires a deterministic operation inventory provider. If route exposure classification, canonical OpenAPI selection, or grammar-backed operation expansion is ambiguous, Gating reports the ambiguity rather than guessing.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "eligible first-party Symfony external HTTP paths against the canonical current OpenAPI inventory"
  extraction: [runtime_normalized_path, openapi_normalized_path, canonical_openapi_source, exposure_classification, operation_inventory_provider]
  body_read: prohibited
  reasoning: none
  escalation: [ambiguous_external_route_classification, multiple_canonical_openapi_candidates, unbounded_route_method, grammar_backed_route_without_operation_inventory, unsupported_route_or_openapi_source]
  executable_evidence: ["Gating Canon056 runtime/OpenAPI operation parity report"]
```
