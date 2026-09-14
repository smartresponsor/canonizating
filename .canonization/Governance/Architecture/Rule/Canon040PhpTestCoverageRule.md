# Canon040PhpTestCoverageRule — Executable PHP Code Requires Adequate Test Coverage

## Identity

Canon: `Canon040`
Gating mirror: `Canon040PhpTestCoverageRule.php`

## Requirement
Canonical SmartResponsor PHP repositories maintain independently adequate executable-code coverage across line, method, and branch dimensions.

Test adequacy is measured from PHPUnit/php-code-coverage results for production source. The ratio of test methods, test classes, or test files to production methods, classes, or files is not a canonical quality measure and must not constitute a pass/fail gate.

## Canonical Thresholds
- Line coverage: at least **80%**.
- Method/function coverage: at least **80%**.
- Branch coverage: at least **70%**.

Each metric is evaluated independently. A stronger result in one dimension may not compensate for inadequate coverage in another.

## Coverage Semantics
Line, method/function, and branch semantics belong to php-code-coverage. In particular, a function or method is considered covered only when php-code-coverage reports it as covered; Gating must not approximate method coverage by counting test names or parsing production methods with regular expressions.

The canonical executable input is a persistent PHPUnit/php-code-coverage text summary containing the standard `Lines`, `Methods`, and `Branches` executed/total counters. Gating consumes those tool-owned counters and does not reimplement coverage collection.

The `Branches` metric must be present before branch coverage can be evaluated. Absence of branch data is incomplete coverage evidence, never 100% branch coverage.

## Result
When all three canonical thresholds are satisfied, the rule passes.

When valid coverage evidence exists but one or more canonical thresholds are below target, the rule reports a warning with the measured percentages and debt classification. Coverage debt is remediation work, but introducing this rule must not make an otherwise executable repository impossible to inspect and improve.

## High Test Debt
A repository is classified as `HIGH_TEST_DEBT` when any of the following is true:

- line coverage is below 50%;
- method/function coverage is below 50%;
- branch coverage is below 40%.

`HIGH_TEST_DEBT` makes the repository eligible for automated test-development/remediation queue admission. Queue ordering policy belongs to the runner/engine and is not defined by this Canon.

## Missing or Stale Evidence
If the testing contract exists but no usable persistent text coverage summary is present, Gating reports a warning that coverage evidence must be generated.

If the summary is malformed, internally inconsistent, stale relative to production source, or lacks any required `Lines`, `Methods`, or `Branches` metric, Gating reports incomplete/invalid evidence rather than inventing a coverage result.

## Responsibility Boundary
PHPUnit/php-code-coverage owns collection and coverage semantics. Gating consumes the standard persistent summary counters, calculates repository-level ratios, validates thresholds, and reports the measured executed/total counts. Gating does not infer coverage from test counts or source-code regexes.

## Guardability
Deterministic runtime warning gate over standard PHPUnit text coverage summaries.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "persistent PHPUnit/php-code-coverage text summary plus production-source freshness metadata"
  extraction: [lines_counter, methods_counter, branches_counter, evidence_timestamp, production_source_timestamp]
  body_read: prohibited
  reasoning: none
  escalation: [missing_metric, malformed_or_stale_summary]
  executable_evidence: ["Gating Canon040 parsed coverage counters"]
```
