# Canon037GeneratedReferenceArtifactRule — Generated Reference Artifacts Are Not Repository Source

## Requirement
Reproducible generated reference/configuration artifacts are derived technical output, not source of truth, and must not be committed as repository source.

The first canonical prohibited artifact is:

- `config/reference.php`

When tooling can regenerate this file from authoritative configuration, container metadata, bundle configuration, or another canonical source, the generated reference must stay outside versioned source history.

## Allowed
A repository may generate `config/reference.php` temporarily during local tooling, diagnostics, documentation generation, or framework inspection when the file remains untracked and disposable.

The canonical source remains the configuration and code from which the reference can be regenerated.

A repository should ignore the generated artifact when its normal tooling creates it persistently in the working tree.

## Prohibited
A canonical repository must not treat `config/reference.php` as authored or authoritative source when it is reproducible generated output.

Non-canonical states include:

- committing `config/reference.php` to Git history;
- reviewing or maintaining it as though it were hand-authored configuration;
- allowing generated reference output to become a competing source of truth;
- relying on edits made directly to the generated file instead of changing the authoritative configuration that produces it.

## Good Examples

```text
config/packages/*.yaml        authoritative configuration
src/**                        authoritative PHP source
config/reference.php          generated locally, ignored/untracked
```

The generated reference may be recreated when needed and does not participate in source history.

```text
config/reference.php          absent from a clean checkout
```

A clean checkout contains only authoritative source and reproducible build/tool output is regenerated on demand.

## Bad Examples

```text
config/reference.php          tracked and committed
```

The repository stores reproducible generated technical output as source.

```text
config/reference.php          manually edited to change application behavior
```

A derived reference has become a competing configuration source instead of being regenerated from the authoritative configuration.

## Relationship to Canon034
Canon034GitignoreBaselineRule establishes general ignore coverage for normal repository noise. Canon037 is narrower and stronger: it identifies a specific reproducible generated artifact that must not become repository source.

A suitable `.gitignore` entry supports this rule, but ignore coverage alone does not make a previously tracked generated file canonical.

## Exceptions
A generated artifact may be versioned only when another explicit platform canon designates that exact artifact as a canonical checked-in release/source contract. The exception must be explicit; generated origin alone never implies permission to commit the artifact.

No such exception is defined for `config/reference.php` by this rule.

## Guardability
Deterministic.

Gating should fail when `config/reference.php` is tracked by Git. A locally generated but untracked/ignored copy is permitted and must not be treated as a source-history violation.

When Git tracking state cannot be determined, Gating may conservatively report a warning rather than claiming that a merely present local generated file is committed source.

## Executable Mapping
Gating mirror: `Canon037GeneratedReferenceArtifactRule.php`.

The shared rule identity is `Canon037`.

## Rationale
Generated reference/configuration output duplicates information already owned by authoritative configuration and framework metadata. Versioning such derivatives creates noisy diffs, stale snapshots, merge churn, and the risk that developers mistake generated output for editable source. Canonical repositories keep reproducible technical output disposable and keep one authoritative configuration source.
