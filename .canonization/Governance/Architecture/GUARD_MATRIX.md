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
| Canon011 | `Canon011NoSilentFailureRule.php` | hard + semantic | implemented; hard swallow patterns fail, ambiguous fallback warns |
| Canon012 | `Canon012TypedBoundaryContractRule.php` | semantic + hard candidates | implemented; profile-gated by `typed_boundary_internal_roots` |
| Canon013 | `Canon013NoPlaceholderProductionLogicRule.php` | hard + semantic | implemented; explicit placeholders fail, TODO/FIXME comments review |
| Canon014 | `Canon014ExecutableResponsibilityRule.php` | semantic/advisory | implemented as executable-size review heuristic |
| Canon015 | `Canon015NoToolingArchitectureLeakRule.php` | hard + semantic | implemented as namespaced-type tooling detector |
| Canon016 | `Canon016ExplicitCompatibilityLifecycleRule.php` | semantic + hard metadata candidates | implemented as lifecycle-metadata review |
| Canon017 | `Canon017DocumentationMatchesRuntimeRule.php` | composite | implemented; profile-gated by `stale_documentation_tokens` |
| Canon018 | `Canon018ComposerIdentityMappingRule.php` | hard | implemented; derives namespace and subject identity from `composer.json:name` |
| Canon019 | `Canon019NoAlternativeLayerTaxonomyRule.php` | hard + semantic | implemented for forbidden `src/` layer roots |
| Canon020 | `Canon020TypedSymfonyRoleRootRule.php` | hard + semantic | implemented for known generic responsibility roots |
| Canon021 | `Canon021CrudingOwnsGenericCrudRule.php` | semantic + hard candidates | implemented; EasyAdmin CRUD explicitly exempt |
| Canon022 | `Canon022StandaloneApplicationDependencyBaselineRule.php` | hard | implemented; standalone detected by Symfony boot surfaces |
| Canon023 | `Canon023DevelopmentComposerSymlinkRule.php` | hard | implemented; local sibling `path` repositories require `symlink: true` |
| Canon024 | `Canon024ProductionComposerBundleRule.php` | hard | implemented; requires `composer.prod.json` for canonical App components and forbids path/symlink repos |
| Canon025 | `Canon025ComponentDualRuntimeModeRule.php` | hard | implemented; verifies standalone boot surfaces plus bundle class |
| Canon026 | `Canon026PlatformVersionBaselineRule.php` | hard | implemented; PHP 8.4+ and Symfony 8.1+ within Symfony 8.x |
| Canon027 | `Canon027DatabaseEngineBaselineRule.php` | hard + contextual | implemented; rejects known non-canonical Doctrine relational drivers |
| Canon028 | `Canon028DualDoctrineConnectionRule.php` | hard + semantic | implemented; checks `data`/PostgreSQL and `infra`/SQLite roles when persistence is present |
| Canon029 | `Canon029MandatoryPhpQualityToolingRule.php` | hard | implemented; requires PHP-CS-Fixer + PHPStan dependencies, configs, and Composer execution scripts |
| Canon030 | `Canon030DoctrineSchemaParityRule.php` | hard + runtime | implemented; requires an executable Doctrine schema-parity contract for ORM+migrations repositories |
| Canon031 | `Canon031PhpDocCoverageRule.php` | warning | implemented; measures meaningful class/method PHPDoc coverage separately with a 70% threshold |
| Canon032 | `Canon032BundleRegistrationRule.php` | hard | implemented; requires reusable component bundle registration in standalone mode |
| Canon033 | `Canon033ComposerManifestIdentityParityRule.php` | hard | implemented; compares development/production Composer identity without requiring identical dependencies |
| Canon034 | `Canon034GitignoreBaselineRule.php` | hard + warning | implemented; missing `.gitignore` fails and incomplete ignore categories warn |
| Canon035 | `Canon035SymfonyContainerReuseRule.php` | hard + warning | implemented; blocks request-time container invalidation and reviews custom container identity |
| Canon036 | `Canon036DocumentationProducerOwnershipRule.php` | hard + semantic | implemented; blocks component-owned root Antora site descriptors while leaving narrative duplication to semantic review |

## Classification

- **hard** — deterministic failure can be expressed without architectural interpretation.
- **semantic** — automation can identify suspicious cases, but architectural intent must be interpreted.
- **advisory** — primarily a review rule; automation may provide hints only.
