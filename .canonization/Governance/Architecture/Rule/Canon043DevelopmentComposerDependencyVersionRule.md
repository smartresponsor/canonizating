# Canon043DevelopmentComposerDependencyVersionRule — Local Development Components Use dev-master

## Identity

Canon: `Canon043`
Gating mirror: `Canon043DevelopmentComposerDependencyVersionRule.php`

## Requirement
When a development `composer.json` connects sibling SmartResponsor components through local Composer `path` repositories, the root manifest uses `"minimum-stability": "dev"` with `"prefer-stable": true`. Any matching package dependency in `require` or `require-dev` must use the exact constraint `dev-master`. Each local first-party path repository must declare `options.versions[<package-name>] = "dev-master"` so Composer keeps the canonical package identity even when the sibling working tree is checked out on a feature branch.

This is the canonical development branch contract for first-party sibling components. The local `path` repository provides the working tree, `options.symlink=true` provides live source linkage under Canon023, and `dev-master` provides a bounded, explicit Composer branch identity instead of an unbounded development constraint.

## Prohibited
Do not declare a locally linked sibling component as `*@dev`, `*`, `dev-main`, an arbitrary feature branch, or an invented semver range in the development Composer manifest.

Do not apply this rule to third-party packages that are not resolved through a local sibling `path` repository. Their version constraints remain governed by their own package/release contracts and the relevant platform baseline rules.

## Rationale
All first-party development components share one stable Composer branch identity. This removes ambiguous unbounded constraints, keeps `composer validate --strict` compatible with the platform's package policy, and avoids repository-by-repository branch-policy drift while preserving local symlink development.

## Good example
A local repository entry points to `../Objecting`, whose Composer package is `objecting/object`, and the consumer declares `"objecting/object": "dev-master"`.

## Bad example
A local repository entry points to `../Objecting`, while the consumer declares `"objecting/object": "*@dev"`.

## Exceptions
Production dependency constraints belong to the production Composer contract and are not governed by this development-only rule. A local path repository that does not resolve to a valid sibling Composer package is reported as a repository/configuration defect rather than silently assigned a guessed package identity.

## Guardability
Hard. Gating can resolve each local sibling `path` repository, read its `composer.json:name`, verify `options.versions[package] = dev-master`, and compare any matching consumer `require` or `require-dev` constraint with the exact canonical value `dev-master`.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "development composer.json local path repositories and directly referenced sibling composer.json identity only"
  extraction: [repository_type, repository_url, sibling_composer_name, consumer_require_constraint]
  body_read: prohibited
  reasoning: none
  escalation: [unresolvable_sibling_path, missing_or_invalid_sibling_composer_identity]
  executable_evidence: ["Gating Canon043 findings"]
```
