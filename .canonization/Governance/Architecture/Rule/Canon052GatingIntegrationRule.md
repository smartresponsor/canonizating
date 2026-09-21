# Canon052GatingIntegrationRule — Canonical Consumers Execute Gating

## Identity

Canon: `Canon052`
Gating mirror: `Canon052GatingIntegrationRule.php`

## Requirement

Every canonical SmartResponsor PHP consumer installs `gating/gate` as a Composer development dependency. Development `composer.json` exposes the sibling `../Gating` repository with `options.symlink: true`, pins `gating/gate` to `dev-master`, exposes a standard `gate` Composer script, and includes `@gate` in the aggregate `quality` script.

The production manifest `composer.prod.json` declares the same Gating package identity without a filesystem path/symlink repository. Gating itself publishes `bin/gating` and its own `gate` and `quality` self-verification scripts.

Consumer-local `.gating/` is an artifact surface only. It may hold reports, evidence, cache data, checksums, generated artifacts, and a non-executable README describing that boundary; normative configuration and executable policy do not live there. Symfony/application configuration belongs in canonical Symfony configuration surfaces.

## Prohibited

Do not copy the Gating engine or policy tree into consumer `.gating/`. Do not require agents to remember a separate ad-hoc Gating invocation outside the standard Composer quality entrypoint. Do not use a local Gating path repository in `composer.prod.json`.

## Rationale

A live development symlink gives every local consumer the current executable canon immediately, while Composer scripts give humans, CI and agents one deterministic verification entrypoint. Production remains reproducible and independent of workstation topology.

## Exceptions

Non-PHP/non-`App\\` repositories that are not canonical Composer consumers are outside this rule. Gating is the owner package and self-validates instead of depending on itself.

## Guardability

Hard.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "composer.json, composer.prod.json, Gating owner package metadata, consumer .gating topology"
  extraction: [gating_dependency, path_repository, symlink_option, composer_scripts, production_dependency, artifact_surface]
  body_read: prohibited
  reasoning: none
  escalation: [nonstandard_consumer_role]
  executable_evidence: ["Gating Canon052 findings"]
```
