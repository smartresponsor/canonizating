# Canon013NoPlaceholderProductionLogicRule — Production Logic Must Not Be Placeholder Logic

## Identity

Canon: `Canon013`
Gating mirror: `Canon013NoPlaceholderProductionLogicRule.php`

## Requirement
Code reachable as production implementation must represent the real behavior promised by its contract.

## Prohibited
Do not ship `Not implemented` exceptions, placeholder success values, TODO/FIXME markers standing in for required behavior, commented-out replacement implementations, or fake branches whose only purpose is to make an incomplete path appear successful.

## Rationale
Placeholder implementation changes incomplete work into hidden runtime debt and makes green tests or gates unreliable evidence of readiness.

## Exceptions
Abstract contracts, explicit test doubles, examples, fixtures, generated stubs, and intentionally disabled experimental code outside the production surface are not production implementation.

## Guardability
Hard for known placeholder constructs; semantic for TODO/FIXME context and fake-success behavior.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "all production implementation PHP and repository-owned runtime scripts"
  extraction: [placeholder_exception_patterns, todo_fixme_markers, fake_success_patterns, commented_replacement_candidates]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [todo_fixme_hit, suspicious_success_fallback, test_double_or_example_ambiguity]
  executable_evidence: ["Gating Canon013 findings"]
```
