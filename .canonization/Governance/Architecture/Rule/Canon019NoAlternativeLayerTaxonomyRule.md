# Canon019NoAlternativeLayerTaxonomyRule — Do Not Introduce a Competing Layer Taxonomy

## Identity

Canon: `Canon019`
Gating mirror: `Canon019NoAlternativeLayerTaxonomyRule.php`

## Requirement
SmartResponsor Symfony components use technical-role topology rather than a parallel Domain/Application/Infrastructure or Port/Adapter/Adaptor architecture. Stable concepts belong under their actual technical role roots.

## Prohibited
Do not introduce `src/Domain/`, `src/Application/`, `src/Infrastructure/`, `src/Port/`, `src/Adapter/`, or `src/Adaptor/` as competing architectural layer roots.

## Rationale
Those taxonomies can be valid in other systems, but in SmartResponsor they create a second organizing principle that conflicts with the role-first component canon and makes placement ambiguous for both humans and agents.

## Exceptions
Words such as Domain or Application may appear deeper in a path when they are genuine semantic context rather than an architectural root. Explicit external-library namespaces are unaffected.

## Guardability
Hard at `src/` root; semantic only for suspicious deeper reuse of layer vocabulary.
