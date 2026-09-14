# Canon005MeaningfulNamespaceTokensRule — Every Namespace Token Must Add Meaning

## Identity

Canon: `Canon005`
Gating mirror: `Canon005MeaningfulNamespaceTokensRule.php`

## Requirement
Every directory/namespace token must identify a real technical role, stable context, coherent family, or meaningful specialization. The goal is not to flatten everything; remove meaningless depth and add meaningful depth where a stable distinction exists.

## Prohibited
Do not create ceremonial folders only for depth, semantic dumping buckets for unrelated concepts, redundant component-name directories, or single-file folders without an expected coherent family.

## Rationale
Namespaces are architecture. Every token should help an engineer predict responsibility.

## Good example
`Service/Resolver/Ordering/...` when `Resolver` is a stable family and `Ordering` is a real specialization.

## Bad example
`Service/Domain/Application/Data/...` when those tokens do not distinguish responsibilities.

## Exceptions
A generic-looking token is not forbidden by spelling alone. `Value/` can be valid for a coherent transport/context value family distinct from `ValueObject/`.

## Guardability
Primarily semantic/advisory; automation may detect known dumping patterns, redundant tokens, or ceremonial single-file folders.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "complete src/ namespace and directory tree"
  extraction: [relative_path, namespace_tokens, sibling_counts, known_redundant_tokens]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [unknown_generic_token, single_file_folder_candidate, context_meaning_ambiguous]
  executable_evidence: ["Gating Canon005 candidates"]
```
