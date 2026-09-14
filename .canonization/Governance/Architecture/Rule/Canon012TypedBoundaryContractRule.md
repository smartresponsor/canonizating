# Canon012TypedBoundaryContractRule — Dynamic Boundaries Must Become Typed Contracts

## Identity

Canon: `Canon012`
Gating mirror: `Canon012TypedBoundaryContractRule.php`

## Requirement
Dynamic external or framework data may enter as arrays or mixed values at a real boundary, but meaningful application contracts must be translated into typed DTOs, value objects, enums, entities, or other explicit typed structures before they become stable internal API.

## Prohibited
Do not use `array<string, mixed>`, unshaped arrays, or `mixed` as the normal long-lived contract between application services when the structure has stable business meaning.

## Rationale
Static analysis can validate declared types; this canon decides where architectural typing is required and prevents transport/config shapes from leaking through the application.

## Exceptions
Configuration readers, decoded external payloads, framework metadata, generic serialization infrastructure, and intentionally dynamic extension points may remain dynamic at their boundary.

## Guardability
Semantic with hard candidates. Gating may identify public mixed/array contracts in selected internal role roots, while profiles define legitimate dynamic boundaries.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "public and protected signatures in configured internal role roots"
  extraction: [relative_path, declared_type, method_signature, parameter_types, return_type, phpdoc_shape_types]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [mixed_or_unshaped_array_candidate, framework_boundary_ambiguity, intentionally_dynamic_extension_point]
  executable_evidence: ["Gating Canon012 findings"]
```
