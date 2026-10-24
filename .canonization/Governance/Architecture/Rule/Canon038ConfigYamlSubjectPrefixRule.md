# Canon038ConfigYamlSubjectPrefixRule — Component YAML Filenames Use the Canonical Subject Prefix

## Identity

Canon: `Canon038`
Gating mirror: `Canon038ConfigYamlSubjectPrefixRule.php`

## Requirement
Component-owned YAML configuration under `config/**` must use a collision-safe filename namespace derived from Canon018.

For a canonical platform component package named `<component-token>/<subject-token>`, every component-owned `.yaml` or `.yml` filename under `config/**` must begin with the normalized subject token followed by `_`.

The YAML filename prefix is derived from the second token of `composer.json:name`; no independent component-to-prefix mapping is allowed.

Hyphens in the Composer subject token normalize to underscores for YAML filenames.

Examples:

- `cataloging/catalog` -> `catalog_*.yaml`;
- `faceting/facet` -> `facet_*.yaml`;
- `paying/payment` -> `payment_*.yaml`.

The remainder of a component-owned filename should use lower snake_case.

## Framework and Vendor Bootstrap Exception
Framework-owned and vendor-owned bootstrap filenames may retain their conventional names when the filename itself identifies the framework integration rather than component semantics.

Canonical shared bootstrap examples include:

- `framework.yaml`;
- `services.yaml`, `services_dev.yaml`, `services_test.yaml`;
- `routes.yaml`, `routes_dev.yaml`, `routes_test.yaml`;
- `doctrine.yaml` and `doctrine_migrations.yaml`;
- `security.yaml`;
- `twig.yaml`;
- `messenger.yaml`;
- `monolog.yaml`;
- `routing.yaml`;
- `validator.yaml`;
- `translation.yaml`;
- `mailer.yaml`;
- `notifier.yaml`;
- `cache.yaml`;
- `csrf.yaml`;
- `lock.yaml`;
- `asset_mapper.yaml`;
- `property_info.yaml`;
- `twig_component.yaml`;
- `ux_turbo.yaml`;
- `rate_limiter.yaml`;
- `api_platform.yaml`;
- `nelmio_api_doc.yaml`;
- `scheb_2fa.yaml`;
- `easyadmin.yaml`;
- `web_profiler.yaml`;
- `controllers.yaml` and `annotations.yaml` when they are Symfony route bootstrap files;
- `reset_password.yaml`;
- `verify_email.yaml`.

The exception is semantic, not a license to give component-owned configuration a generic name. A file named `security.yaml` is exempt only when it is the conventional framework/vendor security bootstrap. Component-specific security policy belongs in a subject-prefixed file such as `catalog_security_access.yaml`.

Environment placement does not change ownership. Conventional framework files may appear under paths such as `config/packages/dev/`, `config/packages/test/`, or `config/packages/prod/` without acquiring a subject prefix.

## Good Examples

```text
config/packages/framework.yaml
config/packages/doctrine.yaml
config/services.yaml
config/routes.yaml
config/packages/catalog_cache.yaml
config/packages/catalog_security_access.yaml
config/routes/catalog_category_move.yaml
config/policy/catalog_data_residency.yaml
```

## Bad Examples

```text
config/packages/cache_policy.yaml
config/packages/faceting_security.yaml
config/packages/doctrine_currencing.yaml
config/routes/category_move.yaml
config/policy/data_residency.yaml
```

The first and last examples are unnamespaced component-owned artifacts. `faceting_security.yaml` uses the component token instead of the Canon018 subject token. `doctrine_currencing.yaml` places the component vocabulary after the semantic filename and therefore does not provide a stable left-edge collision namespace.

## Relationship to Canon018
Canon018 is the only source of component and subject identity. Canon038 consumes the Canon018 subject token and does not redefine it.

For `cataloging/catalog`, PHP subject types use `Catalog*` while component-owned YAML filenames use the normalized lowercase form `catalog_*`.

## Rationale
Standalone components are also assembled into larger applications and monolith-style distributions. Generic component-owned filenames can collide when configuration trees are copied, merged, imported, indexed, or aggregated. A stable left-edge subject namespace keeps ownership visible and prevents one component's configuration artifact from overwriting or shadowing another component's artifact.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "composer subject identity plus all config/**/*.yaml and config/**/*.yml filenames"
  extraction: [composer_subject_token, relative_path, filename, conventional_bootstrap_name_match]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [generic_conventional_filename_with_ambiguous_ownership, unknown_vendor_bootstrap_convention]
  executable_evidence: ["Gating Canon038 findings"]
```
