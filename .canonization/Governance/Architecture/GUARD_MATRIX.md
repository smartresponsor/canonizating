# Architecture Guard Matrix

This matrix describes enforcement opportunities. It does not define normative meaning; the corresponding `Rule/` file does.

| Canon | Gating mirror | Guardability | Current status |
| --- | --- | --- | --- |
| Canon000 | `Canon000ComponentPrefixRule.php` | semantic + partial hard | implemented; profile-gated by `subject_prefix` |
| Canon001 | `Canon001TechnicalRoleFirstRule.php` | hard + semantic | implemented |
| Canon002 | `Canon002InterfaceTreeMirrorsImplementationRule.php` | hard | implemented for typed mirror roots |
| Canon003 | `Canon003DtoIsExplicitRule.php` | hard | implemented |
| Canon004 | `Canon004SubjectFolderPlacementRule.php` | hard + profile exception | implemented; profile-gated by subject vocabulary |
| Canon005 | `Canon005MeaningfulNamespaceTokensRule.php` | semantic/advisory | implemented as warning-level known-pattern detector |
| Canon006 | `Canon006OneDominantTechnicalRoleRule.php` | semantic + hard suffix cases | implemented |
| Canon007 | `Canon007Psr4IdentityRule.php` | hard | implemented |
| Canon008 | `Canon008ComposerDependencyIntegrityRule.php` | hard | implemented; profile-gated by `namespace_packages` |
| Canon009 | `Canon009ComponentHostBoundaryRule.php` | hard + semantic | implemented; profile-gated by `host_namespaces` |
| Canon010 | `Canon010ArchitectureMigrationCompletenessRule.php` | composite | implemented; profile-gated by `forbidden_legacy_tokens` |

## Classification

- **hard** — deterministic failure can be expressed without architectural interpretation.
- **semantic** — automation can identify suspicious cases, but architectural intent must be interpreted.
- **advisory** — primarily a review rule; automation may provide hints only.
