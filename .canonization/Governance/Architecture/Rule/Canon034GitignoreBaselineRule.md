# Canon034GitignoreBaselineRule — Repository Ignore Baseline

## Requirement
Every canonical repository has a `.gitignore` that covers the normal non-source surfaces produced by its stack.

The baseline categories are dependency trees, runtime/cache output, local environment overrides, quality/test caches, IDE-local state, OS noise, and Node dependency output when Node tooling is present.

## Result
Missing `.gitignore` is a hard failure. An existing but incomplete baseline is a warning so the repository can be normalized without blocking unrelated work.

## Non-Goal
This rule does not require one literal shared `.gitignore` template and does not require identical pattern spelling. Equivalent ignore coverage is valid.

## Guardability
Deterministic. Gating classifies recognized ignore patterns by baseline category and reports uncovered categories.

## Rationale
The architectural contract is that generated/local state stays outside source history; exact ignore syntax remains repository-specific.
