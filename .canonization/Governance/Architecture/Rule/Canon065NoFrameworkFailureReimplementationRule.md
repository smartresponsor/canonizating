# Canon065NoFrameworkFailureReimplementationRule — Integrate Framework Error Handling, Do Not Replace It

## Identity

Canon: Canon065
Gating mirror: Canon065NoFrameworkFailureReimplementationRule.php

## Requirement

Failing standardizes failure contracts and evidence. It must not reimplement machinery already owned by Symfony, HTTP, or RFC 9457.

Canonical integration may:

- subscribe thinly to Symfony kernel.exception;
- consume Symfony HttpExceptionInterface or HttpFoundation response primitives;
- render an already-resolved failure using RFC 9457 Problem Details;
- expose deterministic contract/inventory evidence.

Non-canonical replacement includes:

- a parallel exception dispatcher or HttpKernel;
- a custom HttpException hierarchy intended to replace Symfony transport exceptions;
- a private HTTP status-constant catalogue;
- replacement Response, routing, or Security machinery;
- a custom error JSON protocol that competes with RFC 9457.

A wrapper or adapter is admissible only when it adds platform failure-contract semantics rather than reproducing framework behavior.

## Category/status caution

A custom FailureCategory-to-HTTP-status taxonomy is not canonical merely because it is abstract. It requires demonstrated transport-independent semantics. Otherwise standard HTTP status semantics remain authoritative.

## Guardability

Hard for known framework-replacement declarations and custom transport primitives. Semantic/advisory for abstractions whose duplication cannot be proven syntactically.

## Evidence Contract

evidence_contract:
  coverage: "Failing source framework/protocol boundary"
  extraction: [declared_types, inheritance, imports, response_protocol_literals]
  body_read: targeted
  reasoning: distinguish integration from replacement
  escalation: [custom_http_exception_hierarchy, custom_http_status_catalogue, custom_http_kernel, competing_error_protocol]
  executable_evidence: ["Gating Canon065 findings"]
