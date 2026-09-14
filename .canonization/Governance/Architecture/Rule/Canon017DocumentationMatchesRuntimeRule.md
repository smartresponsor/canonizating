# Canon017DocumentationMatchesRuntimeRule — Documentation Must Describe the Current Runtime

## Identity

Canon: `Canon017`
Gating mirror: `Canon017DocumentationMatchesRuntimeRule.php`

## Requirement
Architecture documentation, README examples, PHPDoc semantics, configuration examples, and operational instructions must describe the currently supported runtime/API rather than a superseded topology or contract.

## Prohibited
Do not leave old namespaces, deleted classes, obsolete paths, renamed commands, retired configuration keys, or superseded architectural recommendations in authoritative current documentation after migration completes.

## Rationale
Documentation participates in architecture because humans and agents use it to generate new code and operational decisions. Stale documentation recreates retired architecture.

## Exceptions
Historical records, migration notes, changelogs, and explicitly versioned documentation may intentionally mention obsolete structures when clearly identified as historical.

## Guardability
Composite: hard for configured stale tokens and broken examples/references; semantic for prose that is technically valid but architecturally obsolete.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "authoritative current documentation, README examples, PHPDoc, and operational/configuration examples"
  extraction: [configured_stale_tokens, namespace_references, path_references, command_names, configuration_keys]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [stale_token_hit, runtime_documentation_mismatch, historical_vs_current_status_ambiguous]
  executable_evidence: ["Gating Canon017 findings"]
```
