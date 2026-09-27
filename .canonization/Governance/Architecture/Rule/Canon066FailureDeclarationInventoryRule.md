# Canon066FailureDeclarationInventoryRule — Declared Failures Produce Deterministic Operation Inventory

## Identity

Canon: Canon066
Gating mirror: Canon066FailureDeclarationInventoryRule.php

## Requirement

Failure inventory must be derived from explicit declarations, not guessed by scanning arbitrary controller control flow.

A consumer exposes concrete failures through the shared Failing provider contract and explicitly declares operation membership through the shared operation inventory provider contract.

The deterministic evidence unit is:

    HTTP_METHOD + normalized_path + failure_code + HTTP_STATUS

The Failing owner must expose this evidence through a versioned, deterministic machine-readable export surface. Equivalent inventories must serialize in stable ordering independent of consumer/provider registration order.

The central Failing registry may aggregate declarations at runtime but is not itself a source-code catalogue.

Unknown failure codes referenced by an operation inventory are non-canonical.

Registration alone must never imply operation membership. Shared security or framework failures such as 401, 403, or an intentionally public 500 may enter operation evidence only through deterministic explicit applicability owned by the relevant consumer/security/host integration. Unknown throwables remain framework/runtime behavior and must not be auto-promoted into a public operation failure contract.

Duplicate failure codes, duplicate exception mappings, and duplicate operation inventory identities are non-canonical because they make runtime evidence ambiguous.

## Non-goals

Canon066 does not itself define OpenAPI response parity. The later L5 failure-status comparison consumes its deterministic evidence. Known concrete runtime failure statuses require exact OpenAPI response codes; OpenAPI `default` and wildcard ranges such as `4XX`/`5XX` do not satisfy an exact known failure and do not widen the runtime denominator.

Canon066 also does not infer exhaustive failures from throw statements, responder branches, exception subscribers, or arbitrary control-flow analysis.

## Guardability

Hard where explicit provider/inventory contracts are present. Consumer adoption is incremental until the Failing contract is calibrated.

## Evidence Contract

evidence_contract:
  coverage: "declared failure definitions and operation failure membership"
  extraction: [failure_code, exception_mapping, operation_method, operation_path, declared_http_status]
  body_read: declarations_only
  reasoning: none
  escalation: [duplicate_failure_code, duplicate_exception_mapping, duplicate_operation_inventory, unknown_operation_failure]
  executable_evidence: ["Failing registry/inventory validation", "Gating Canon066 findings"]
