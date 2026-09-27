# Canon058CanonicalOpenApiSourceRule — Canonical OpenAPI Source Lives Under Config OpenAPI

## Identity

Canon: `Canon058`
Gating mirror: `Canon058CanonicalOpenApiSourceRule.php`

## Requirement

A repository that owns a first-party OpenAPI contract must keep the canonical current OpenAPI source under:

```text
config/openapi/
```

The canonical source must be YAML and must use the Canon038 subject-prefix filename rule.

For a component whose Canon018 subject token normalizes to `<subject>`, the canonical OpenAPI source is named with the form:

```text
config/openapi/<subject>_openapi.yaml
```

Additional canonical surfaces may use the same left-edge subject namespace and an explicit surface qualifier:

```text
config/openapi/<subject>_public_openapi.yaml
config/openapi/<subject>_internal_openapi.yaml
```

Generic filenames such as `openapi.yaml` are not canonical component-owned sources because they lose the collision-safe ownership namespace required by Canon038.

## Canonical Source Versus Artifacts

Canonical OpenAPI source, generated OpenAPI artifacts, and published documentation are distinct concepts.

- `config/openapi/*.yaml` is the canonical source location.
- `var/**` is generated/runtime output and must not be canonical source.
- `public/**` is publication surface and must not be canonical source.
- `docs/**` is human documentation and must not be canonical source.
- `legacy/**` is historical compatibility material and must not be canonical source.
- root `api/**` is not a canonical source location in this platform; use `config/openapi/**` instead.

Generated or published OpenAPI copies may exist only when the current canonical source is still deterministic and lives under `config/openapi/`.

## Canonical Selection

If exactly one canonical candidate exists under `config/openapi/`, it is the canonical current OpenAPI source.

If multiple canonical candidates exist under `config/openapi/`, the repository profile must declare which one is the current canonical source using a supported profile key such as:

```yaml
canonical_openapi_path: config/openapi/<subject>_openapi.yaml
```

A declared canonical source must exist, must be under `config/openapi/`, must be YAML, and must satisfy the Canon038 subject-prefix naming rule.

## Good Examples

```text
config/openapi/billing_openapi.yaml
config/openapi/catalog_openapi.yaml
config/openapi/crud_openapi.yaml
config/openapi/order_openapi.yaml
config/openapi/shipping_openapi.yaml
config/openapi/billing_public_openapi.yaml
```

## Bad Examples

```text
config/openapi/openapi.yaml
config/openapi/billing_openapi.json
api/openapi.yaml
docs/openapi.yaml
public/openapi.json
var/openapi/openapi.json
legacy/openapi.yaml
```

## Relationship to Canon038

Canon058 does not redefine YAML ownership naming. It consumes Canon038's subject-prefix rule and applies it specifically to OpenAPI contract sources.

For package `billing/billing`, the source prefix is `billing_`. For package `cruding/crud`, the source prefix is `crud_`. The prefix is derived from Canon018 package identity, not from an independent mapping.

## Relationship to Canon056

Canon058 identifies the canonical OpenAPI source. Canon056 compares the external runtime API path surface against that source.

Canon056 must not silently merge multiple OpenAPI files or compare against generated/public/legacy artifacts when Canon058 cannot identify a canonical current source.

## Non-goals

Canon058 does not define:

- OpenAPI path/method parity;
- request/response schema correctness;
- API test coverage;
- OpenAPI generation tooling;
- publication of rendered API docs.

