# Canon014ExecutableResponsibilityRule — Executable Objects Orchestrate Instead of Accumulating Roles

## Identity

Canon: `Canon014`
Gating mirror: `Canon014ExecutableResponsibilityRule.php`

## Requirement
Commands, runners, handlers, invokers, and similar executable entry objects may orchestrate a workflow, but stable subordinate technical responsibilities must be delegated to typed collaborators.

## Prohibited
Do not let one executable object simultaneously own unrelated parsing, persistence, validation, policy, report formatting, transport, retry, and filesystem implementation merely because it is the entry point.

## Rationale
Orchestration is a legitimate responsibility. Accumulating unrelated implementation roles creates a procedural monolith and defeats the role-first architecture.

## Exceptions
Small cohesive executable objects may directly perform trivial local transformations when extracting a collaborator would add no stable responsibility or reusable concept.

## Guardability
Semantic. Gating may flag unusually large executable objects or excessive collaborator/implementation breadth for review but cannot prove responsibility boundaries from size alone.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "command, handler, runner, invoker, and executable-entry PHP declarations"
  extraction: [relative_path, declaration_name, method_count, size_metrics, collaborator_types, responsibility_markers]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [size_or_breadth_outlier, multiple_stable_responsibility_markers]
  executable_evidence: ["Gating Canon014 candidates"]
```
