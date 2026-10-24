# Canon062OpenApiProfileCanonicalPathAliasRule — One Canonical OpenAPI Profile Path Declaration

## Identity

Canon: `Canon062`
Gating mirror: `Canon062OpenApiProfileCanonicalPathAliasRule.php`

## Requirement

The preferred profile key for declaring the canonical OpenAPI source is:

```yaml
canonical_openapi_path: config/openapi/<subject>_openapi.yaml
```

The legacy aliases:

```text
openapi_contract_path
openapi_path
api_openapi_path
```

exist only for compatibility. They must not create a second or conflicting source declaration.

## Drift Rules

Hard failure:

- two or more OpenAPI path keys resolve to different normalized paths.

Warning:

- a legacy alias is used without `canonical_openapi_path`;
- `canonical_openapi_path` and one or more legacy aliases coexist but resolve to the same normalized path;
- multiple legacy aliases coexist and resolve to the same normalized path.

Pass:

- only `canonical_openapi_path` is present.

Not applicable:

- no OpenAPI path profile key is declared.

Path normalization for comparison is lexical and repository-relative: slash direction and a leading slash do not create distinct declarations.

## Examples

Canonical:

```yaml
canonical_openapi_path: config/openapi/billing_openapi.yaml
```

Compatibility warning:

```yaml
openapi_path: config/openapi/billing_openapi.yaml
```

Compatibility warning without semantic drift:

```yaml
canonical_openapi_path: config/openapi/billing_openapi.yaml
openapi_path: config/openapi/billing_openapi.yaml
```

Non-canonical drift:

```yaml
canonical_openapi_path: config/openapi/billing_openapi.yaml
openapi_path: public/openapi.json
```

## Relationship to Canon058 and Canon059

Canon058 defines what qualifies as a canonical OpenAPI source. Canon059 requires runtime/OpenAPI parity to consume that canonical source. Canon062 closes declaration drift by ensuring the profile does not present competing source locators.

## Non-goals

Canon062 does not validate OpenAPI document syntax, generated artifact freshness, runtime/OpenAPI path parity, or the existence of the declared source file. Those responsibilities remain with adjacent rules and tooling.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "supported OpenAPI profile path keys"
