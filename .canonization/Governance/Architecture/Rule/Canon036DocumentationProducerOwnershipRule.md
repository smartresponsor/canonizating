# Canon036DocumentationProducerOwnershipRule — Components Produce Documentation; Documentating Owns the Antora Site

## Requirement
Ordinary platform component repositories are documentation producers. They may publish repository-facing Markdown and Antora-compatible AsciiDoc content, but they do not own an independent Antora site.

The platform documentation ownership model is:

> Components produce documentation; Documentating assembles and publishes it.

## Allowed
An ordinary component repository may contain repository-facing Markdown such as:

- `README.md`;
- `CHANGELOG.md`;
- `RELEASE_NOTES.md`;
- other `.md` files for GitHub visitors, onboarding, release notes, repository maps, and similar repository-facing concerns.

An ordinary component repository may also expose an Antora content-producer surface under `docs/`, including:

- `docs/antora.yml`;
- `docs/modules/ROOT/nav.adoc`;
- `docs/modules/ROOT/pages/**`;
- other component-owned `.adoc` material inside the component documentation tree.

This is an Antora **content producer**, not a lightweight or local Antora installation.

## Prohibited
Outside the `Documentating` repository, a component must not own the platform's full Antora-site responsibilities. In particular, an ordinary component must not:

- own a central/root Antora playbook such as `antora-playbook.yml` or `antora-playbook.yaml`;
- own the central Antora UI or platform publishing pipeline;
- establish a separate component-specific documentation portal;
- relocate the component descriptor to a root `antora.yml` as though the component repository were the site root;
- maintain an independent second narrative copy merely to satisfy Antora.

## Documentation Source and Drift
Markdown and AsciiDoc are two documentation surfaces, not permission to maintain two equal narrative sources for the same document.

If Markdown is the canonical narrative source for a document, an AsciiDoc Antora entry point should be a thin wrapper, include, index, or navigation-oriented entry point rather than a manually maintained duplicate of the same prose.

If AsciiDoc is the canonical narrative source for a document, an independent Markdown copy of the same narrative should not be maintained in parallel.

Two peer copies of one document that can diverge over time are non-canonical documentation drift.

## Good Examples

```text
Tagging/
├── README.md
├── CHANGELOG.md
└── docs/
    ├── antora.yml
    └── modules/
        └── ROOT/
            ├── nav.adoc
            └── pages/
                └── index.adoc
```

The component owns repository-facing Markdown plus an Antora producer surface. It does not own the site playbook or publishing stack.

```text
Component README.md                  canonical narrative
docs/modules/ROOT/pages/index.adoc   thin Antora entry point/include
```

The Antora page does not manually duplicate the complete README narrative.

## Bad Examples

```text
SomeComponent/
├── antora-playbook.yml
├── README.md
├── ui/
└── docs/
    └── modules/ROOT/pages/**
```

The component is acting as an independent Antora site owner instead of a content producer.

```text
README.md                             full narrative copy A
docs/modules/ROOT/pages/readme.adoc   manually maintained full narrative copy B
```

Independent peer copies create documentation drift even when they begin with identical content.

## Documentating Exception
`Documentating` is the platform documentation-site owner and is explicitly exempt from the component-site prohibition.

Documentating may own the full Antora site surface, including the central playbook, canonical builder, UI/assets, aggregation, publishing workflow, and publication responsibility.

The currently established site-owner path includes `antora-playbook.yml`, canonical builder tooling such as `tools/build_antora_site.py`, publishing workflow, UI/assets, component-documentation aggregation, and publication ownership.

## Guardability
Hard executable checks are appropriate only for deterministic ownership/topology invariants. Gating may fail an ordinary component repository that owns a root Antora playbook or places `antora.yml` at repository root, while explicitly exempting Documentating.

Narrative equivalence, thin-wrapper quality, and Markdown/AsciiDoc duplication are semantic concerns. They must not be hard-failed by content-similarity heuristics unless a future deterministic contract replaces semantic interpretation.

## Executable Mapping
Gating mirror: `Canon036DocumentationProducerOwnershipRule.php`.

The shared rule identity is `Canon036`; Gating enforces only the deterministic ownership boundary while this document remains authoritative for the complete semantic rule.

## Rationale
Component repositories should stay focused on producing documentation alongside the code they own. Centralizing Antora assembly and publication in Documentating prevents fragmented portals, duplicated publishing infrastructure, inconsistent UI, and narrative drift while preserving component-local ownership of documentation content.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "documentation descriptor/playbook/UI/publishing paths plus narrative-duplication candidates"
  extraction: [antora_descriptor_paths, playbook_paths, publishing_surface_paths, duplicate_narrative_candidates]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [possible_thin_wrapper_vs_duplicate_narrative, documentating_ownership_ambiguity]
  executable_evidence: ["Gating Canon036 topology findings"]
```
