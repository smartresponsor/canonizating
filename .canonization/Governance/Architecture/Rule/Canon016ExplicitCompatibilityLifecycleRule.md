# Canon016ExplicitCompatibilityLifecycleRule — Compatibility Surfaces Require an Explicit Lifecycle

## Identity

Canon: `Canon016`
Gating mirror: `Canon016ExplicitCompatibilityLifecycleRule.php`

## Requirement
A legacy alias, deprecated API, compatibility wrapper, transitional mapping, or migration bridge must state why it exists and the condition under which it is removed.

## Prohibited
Do not preserve duplicate old/new architecture indefinitely without an explicit compatibility purpose, deprecation signal, migration owner, or removal condition.

## Rationale
Unbounded compatibility turns a migration into permanent dual architecture and makes both contracts appear equally canonical.

## Exceptions
Long-lived public backward compatibility may remain when it is an intentional supported product contract; it still requires explicit status and ownership rather than accidental survival.

## Guardability
Semantic with hard metadata candidates. Gating may flag compatibility/legacy/deprecated surfaces that lack an accepted lifecycle marker.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "all tracked current source and configuration surfaces capable of carrying compatibility APIs or mappings"
  extraction: [deprecated_markers, legacy_aliases, wrappers, transitional_mappings, lifecycle_metadata]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [compatibility_candidate_without_lifecycle, public_backward_compatibility_claim, removal_condition_ambiguous]
  executable_evidence: ["Gating Canon016 candidates"]
```
