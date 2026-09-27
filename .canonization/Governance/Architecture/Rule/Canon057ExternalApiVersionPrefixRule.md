# Canon057ExternalApiVersionPrefixRule — Versioned External APIs Use /api/vN Prefix

## Identity

Canon: `Canon057`
Gating mirror: `Canon057ExternalApiVersionPrefixRule.php`

## Requirement

When a first-party external HTTP API route is versioned, the version segment belongs immediately to the API channel prefix:

```text
/api/vN/...
```

The version token is the first path segment after `api`. It must match:

```regex
^v[1-9][0-9]?$
```

Therefore `v1` through `v99` are canonical. `v0`, `v01`, `v001`, `v100`, `version1`, and bare numeric version tokens are non-canonical.

## Canonical examples

```text
/api/v1/billing/invoices
/api/v1/orders
/api/v2/vendor/edit/123
/api/v10/shipping/carriers
```

## Prohibited examples

```text
/api/billing/v1/invoices
/api/vendor/v1
/api/1/vendor
/api/version1/vendor
/api/v01/vendor
/api/v100/vendor
```

## Grammar-backed routes

For grammar-backed API delivery surfaces such as Cruding, `/api/vN` is a delivery/channel prefix and is outside the grammar input.

The grammar owner receives the remaining path after stripping the channel prefix. For example, `/api/v1/vendor/edit/123` supplies `vendor/edit/123` to Cruding. The token `v1` must not be interpreted as a resource path, operation, identity, slug, view, subject, or other grammar token.

## Legacy compatibility

This Canon does not automatically fail every unversioned `/api/...` route. Existing unversioned API routes may continue only as explicit compatibility or migration surfaces governed by the compatibility lifecycle canon.

New versioned external API routes must not place the version token anywhere except immediately after `/api`.

## Non-goals

Canon057 does not define OpenAPI parity, endpoint coverage, API breaking-change policy, supported API lifetimes, or whether an unversioned legacy API must be removed immediately.

## Guardability

Hard for first-party route paths that contain a version-looking `vN` segment anywhere under `/api`. Contextual for determining whether an unversioned `/api/...` route is legacy compatibility, canonical current API, or intentionally unversioned.

## Evidence Contract
