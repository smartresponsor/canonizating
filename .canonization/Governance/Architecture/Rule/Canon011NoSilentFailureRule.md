# Canon011NoSilentFailureRule — Mandatory Failures Must Not Be Silenced

## Identity

Canon: `Canon011`
Gating mirror: `Canon011NoSilentFailureRule.php`

## Requirement
When an operation is required by the active contract, failure must remain observable. Propagate, translate, or explicitly report the failure. A fallback is valid only when fallback behavior is itself part of the declared contract.

## Prohibited
Do not use empty `catch` blocks, blanket exception swallowing, or `catch` branches that silently return empty/null/false success-like values for mandatory operations.

## Rationale
Silent failure destroys causality and converts infrastructure or domain defects into misleading business state.

## Exceptions
Best-effort telemetry, optional enrichment, probing, and other explicitly non-authoritative operations may suppress failure when the contract states that behavior and the suppression remains diagnosable where appropriate.

## Guardability
Hard for empty catches and known swallow patterns; semantic for deciding whether a fallback is contractually valid.
