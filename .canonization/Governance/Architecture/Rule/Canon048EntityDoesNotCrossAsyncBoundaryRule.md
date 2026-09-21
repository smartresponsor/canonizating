# Canon048EntityDoesNotCrossAsyncBoundaryRule — Entity Does Not Cross Async Boundary

## Identity

Canon: `Canon048`
Gating mirror: `Canon048EntityDoesNotCrossAsyncBoundaryRule.php`

## Requirement

Asynchronous Message transport contracts carry scalar/value data and must not directly depend on project Doctrine Entity classes. Symfony Console commands under `src/Command/` are application entrypoints, not asynchronous transport contracts.

## Prohibited

Do not import or type project Entity classes from asynchronous transport contracts under `src/Message/`. Do not infer asynchronous transport semantics merely from the canonical Symfony `src/Command/` technical role.

## Rationale

Transport contracts must remain serializable, stable and persistence-detached.

## Exceptions

Symfony Console command classes under `src/Command/` are outside this async-boundary rule. If a future command-shaped transport contract is introduced, it must live under an explicitly transport-owned Message surface rather than overloading the Symfony Console Command role.

## Guardability

Hard.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "src/Entity plus asynchronous transport contracts under src/Message"
  extraction: [entity_fqcn, transport_reference]
  body_read: candidates_only
  reasoning: none
  escalation: []
  executable_evidence: ["Gating Canon048 findings"]
```
