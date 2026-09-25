# Canon031PhpDocCoverageRule — PHPDoc Coverage Requires Meaningful Descriptions

## Identity

Canon: `Canon031`
Gating mirror: `Canon031PhpDocCoverageRule.php`

## Requirement
Canonical platform PHP repositories maintain at least 70% meaningful PHPDoc coverage for classes and contract-significant methods separately. Canon031 MUST NOT create documentation debt from implementation noise such as private helpers, PHP magic methods, constructors/destructors, or conventional `get*`/`set*`/`is*`/`has*` accessors.

## Meaningful Coverage
A declaration is covered only when it has an immediately preceding PHPDoc block with a human-readable description. Tags such as `@param`, `@return`, `@throws`, `@deprecated`, and similar metadata do not count as a description by themselves.

The executable minimum for a description is at least five words and at least 30 non-markup characters after PHPDoc decoration is removed. Obvious placeholders such as `TODO`, `TBD`, `Description`, `Method description`, `Class description`, `Getter`, `Setter`, or similarly empty labels are not coverage.

## Metrics
Class coverage and contract-method coverage are calculated independently. One category may not mask debt in the other.

The method denominator includes named public/protected behavior and excludes private helpers, magic methods, constructors/destructors, and conventional property-style accessors whose signatures already state the contract. Excluded methods are reported as a separate count so denominator changes remain visible rather than silently improving the score.

## Result
Coverage below 70% is a warning rather than a hard failure. The warning must report percentages and representative uncovered or weak symbols so an agent can perform semantic review, update stale comments, and increase documentation coverage.

## Responsibility Boundary
Gating measures presence and minimal semantic substance only. It does not decide whether a comment is fully correct, current, or sufficiently explanatory. That semantic review belongs to ChatGPT/agent execution against the actual implementation.

## Guardability
Deterministic warning gate. Eligible classes and methods are counted from PHP source; DocBlocks are classified as `missing`, `tags_only`, `placeholder`, `too_short`, or `covered`.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "all PHP class-like declarations plus contract-significant public/protected methods under production source roots; private helpers, magic methods, constructors/destructors, and conventional accessors excluded"
  extraction: [relative_path, declaration_kind, declaration_name, method_visibility, denominator_eligibility, adjacent_docblock, minimal_description_classification]
  body_read: prohibited
  reasoning: none
  escalation: [token_parse_failure, questionable_documentation_quality_after_threshold_measurement]
  executable_evidence: ["Gating Canon031 coverage counters", "representative weak symbols"]
```
