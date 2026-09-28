# Canonical Rules Journal

## 2026-09-27 — Failing mandatory standalone adoption

Failing is promoted from an optional shared package to a mandatory standalone runtime baseline dependency. Canon022 now requires `failing/failure` in both development and production runtime manifests for standalone platform applications and requires `App\\Failing\\FailingBundle` activation in `config/bundles.php`. Development path/symlink/version/closure semantics remain owned by Canon023/043/045; production path prohibition remains owned by Canon024. The Failing owner now exposes a real reusable Symfony bundle that autoconfigures consumer failure providers without enumerating consumers.

## 2026-09-27 — Failing consumer calibration and Canon053 admission

Paying is the first real consumer calibration: `payment.payment_not_found` is declared consumer-side and produces deterministic `GET /api/payments/{id} + 404` evidence through the shared Failing contracts without any Payment-specific branch in Failing. Cruding and Billing were inspected read-only because both currently contain parallel dirty work; their existing local exception/problem/error-response machinery confirms the same migration contour but was not modified.

Canon053 is amended narrowly: `Failing` becomes the fourteenth explicit shared sibling symlink exception. The rule remains a closed allow-list; no wildcard or capability-to-capability symlink relaxation is introduced.

Cruding calibration exposed an ownership correction in the central contract: existing public consumer codes include `crud_not_found` while Paying exposes `payment-not-found`. Therefore Failing must not prescribe dotted code vocabulary. Canon064 is clarified so the shared component may enforce only a minimal safe machine-token envelope; exact separator and business naming remain consumer-owned.

Searching completes the initial cross-consumer calibration with a direct-controller pattern: the existing `search_index_not_found` 404 outcome is declared once and attached to both PATCH and DELETE operation inventories. Together, Paying (outcome-driven), Cruding (exception-driven), and Searching (direct-controller) demonstrate that Canon064-066 do not require consumer-specific branches in Failing.

Shared/framework applicability is now fixed explicitly: registering a failure never attaches it globally to every operation. Security/framework outcomes enter exact runtime inventory only through deterministic operation membership owned by the relevant integration. Unknown throwables are not auto-converted into an implicit public 500 contract; Symfony/runtime handling remains authoritative unless a stable public internal-error failure is intentionally declared.

OpenAPI matching semantics are also fixed for the upcoming L5 failure-status rule: deterministic runtime 4xx/5xx evidence must be represented by the exact OpenAPI response code. `default`, `4XX`, and `5XX` may describe ambient behavior but cannot satisfy or widen exact declared-failure parity. Failing does not own successful 2xx/3xx outcome inventory; success-status parity remains a separate architectural concern.

## 2026-09-27 — Failing contract architecture foundation

Materialized rules: Canon064 through Canon066.

Failing is established as a consumer-agnostic failure-contract mechanism rather than a central business-error catalogue. The central component owns declaration grammar, provider aggregation, declared exception lookup, RFC 9457 projection, and deterministic operation failure inventory. Concrete business failure codes, titles, problem types, exception mappings, and operation membership remain owned by each consumer repository.

The architecture explicitly adopts an anti-wheel boundary: Symfony owns exception dispatch and HTTP framework mechanics; HTTP/Symfony own status semantics; RFC 9457 owns Problem Details representation. Failing may integrate those mechanisms but may not replace them with parallel exception dispatch, HttpException hierarchies, private HTTP status catalogues, Response/HttpKernel/Security substitutes, or competing error JSON protocols.

The initial contract deliberately omits a custom FailureCategory-to-status taxonomy. Such a taxonomy is admitted only if consumer calibration demonstrates transport-independent semantic value. Runtime failure evidence is declaration-driven rather than inferred from arbitrary PHP control flow. Canon066 prepares the deterministic denominator for later L5 OpenAPI response parity but does not itself define that parity.

## 2026-09-26 — Canonical OpenAPI source and contract grammar closure

Materialized rules: Canon058, Canon059, Canon060.

Canonical OpenAPI source is now separated from generated/public/documentation artifacts. Current first-party OpenAPI source belongs under `config/openapi/` and must use the Canon038 subject-prefixed YAML filename shape, for example `config/openapi/billing_openapi.yaml` or `config/openapi/crud_openapi.yaml`.

`var/**`, `public/**`, `docs/**`, `legacy/**`, and root `api/**` are not canonical source locations. Multiple current OpenAPI sources under `config/openapi/` require an explicit profile declaration such as `canonical_openapi_path`. Canon056 consumes the resulting canonical source for runtime/OpenAPI parity and must not merge generated or historical OpenAPI artifacts into its denominator.

Canon059 makes that source binding explicit: runtime/OpenAPI parity may only consume the Canon058-compatible canonical source. Canon060 mirrors Canon057 on the OpenAPI side, so versioned paths in the canonical contract also place `vN` immediately after `/api`.

Canon061 adds the producer dependency contour without expanding Canon022's universal baseline: repositories that own OpenAPI sources/config must declare direct `nelmio/api-doc-bundle`, while repositories without OpenAPI responsibility do not need the bundle.

Canon062 closes profile-level declaration drift. `canonical_openapi_path` is the preferred key; legacy aliases remain compatibility-only. Conflicting values across supported OpenAPI path keys are hard failures, while legacy-only or duplicate same-value aliases are warnings so repositories can converge without hiding semantic drift.

Canon063 closes Level 4 API contract coverage. Canon056 remains path-only; Canon063 independently enforces bidirectional hard parity of explicitly declared `HTTP_METHOD + normalized_path`. Ordinary external API routes without an explicit method set are non-deterministic and fail method parity rather than being guessed as GET. Grammar-backed routes remain contextual until their owner provides a deterministic operation inventory provider.

## 2026-09-26 — External API version prefix placement

Materialized rule: Canon057.

Versioned external API routes now reserve the segment immediately after `/api` for the version token. Canonical tokens match `v1` through `v99`; leading-zero, zero, three-digit, numeric-only, and prose version tokens are non-canonical. Therefore `/api/v1/billing/invoices` is canonical while `/api/billing/v1/invoices` is not.

For grammar-backed delivery surfaces such as Cruding, `/api/vN` is a channel/version prefix and is not part of the CRUD grammar input. Cruding receives the remaining `crudPath` after stripping `/api/vN`, so `v1` is never interpreted as a resource, operation, identity, slug, view, subject, or other CRUD token.

Canon057 intentionally does not require immediate removal of all existing unversioned `/api/...` routes. Existing unversioned routes are compatibility/migration surfaces governed by compatibility lifecycle evidence; new versioned routes must use `/api/vN/...`.

## 2026-09-26 — External HTTP API / OpenAPI operation parity

Materialized rule: Canon056.

Canonical API-bearing Symfony applications now treat the external runtime HTTP surface and the canonical current OpenAPI document as two representations of one operation contract. The deterministic comparison key is HTTP method plus normalized path. Runtime operations missing from OpenAPI are undocumented external surface; OpenAPI operations missing from runtime are stale/orphan contract surface.

Canon056 intentionally stops at path-level OpenAPI mirror plus method-level evidence. It does not infer API test coverage, response/status-code coverage, parameter coverage, security coverage, breaking-change policy, or URL version-segment placement. Repositories without an external HTTP API are not required to add OpenAPI merely to satisfy the rule. Where external-route classification, canonical OpenAPI selection, route method inventory, or grammar-backed operation expansion is ambiguous, Gating must report ambiguity instead of guessing.

Cruding clarified the important exception contour: generic delivery routes such as `/api/{crudPath}` and tokenized catch-all routes are not ordinary single OpenAPI operations. Their real external operation inventory is owned by the Cruding grammar/reserved-token model; Gating must consume an explicit operation inventory provider rather than reinterpreting CRUD tokens itself.

## 2026-09-26 — Canon001/Canon004 topology drift correction

Canon001 and Canon004 are explicitly complementary rather than competing topology rules. Canon001 owns only the first semantic token below `src/`: the technical role. Canon004 owns the earliest admissible placement of a configured component subject directory in ordinary technical trees. The former abstract `Invoice` example obscured the distinction between repository identity, subject token, technical direction, and terminal type, so the normative examples now use the real `Cruding` / `Crud` platform vocabulary. `src/Service/Operation/CrudApiCreateOperation.php` is canonical without a subject directory; if a `Crud` grouping directory is genuinely needed, `src/Service/Operation/Crud/CrudApiCreateOperation.php` is canonical while `src/Service/Crud/...` is premature.

This correction does not require ceremonial depth. The intermediate token must add stable technical or semantic meaning; `Common`, `General`, `Misc`, or other filler folders remain non-canonical under Canon005. The existing Entity infrastructure exception in Canon004 remains unchanged.

## 2026-09-24 — Platform/consumer identity boundary

Materialized rule: Canon055.

The platform is explicitly multi-domain. `Smart Responder`, `Smart Responsor`, and `SmartResponsor` identify one consumer/domain and no longer act as umbrella names for the platform, project, architecture canon, repository family, components, or shared services.

Current human-facing documentation and repository/package descriptions use neutral platform vocabulary. Existing machine locators such as a GitHub owner, Composer vendor/package identity, schema identifier, or URL host remain technical identifiers and do not acquire platform-brand authority.

Gating implements Canon055 as a detection-only rule: ambiguous or incorrect prose fails with evidence, while remediation remains an agent/chat responsibility so replacements preserve the actual sentence subject. Explicit consumer/domain references, historical records, and the Canon055 normative alias definition are exempt from the hard failure contour.

## 2026-09-23 — Enveloping optional Host composition

Canon022 now explicitly keeps `enveloping/envelope` outside the mandatory standalone application dependency baseline. Enveloping is a cross-cutting Host-composition capability: the Host may envelope objects or operations from consumer components without making those consumers depend on Enveloping. The package itself is exempt from the CRUD/UI application baseline so its standalone runtime can exist for debug/container verification without introducing unrelated platform dependencies. Canon041 and Canon042 likewise exclude this headless standalone runtime from browser/UI tooling and behavioral-UI coverage. Enveloping must remain consumer-agnostic and must not hardcode domain-repository knowledge.

This journal records how recurring architecture patterns are consolidated into the platform canon. The normative wording itself lives in `Rule/`.

## 2026-09-22 — Doctrine physical identifier naming

Materialized rule: Canon054.

The current Doctrine metadata contract now explicitly separates PHP naming from physical relational naming: PHP properties/methods remain camelCase while tables, columns, join columns, indexes, and unique constraints use lower_snake_case. Standalone persistence owners use `doctrine.orm.naming_strategy.underscore_number_aware`, matching Host behavior and preventing standalone/Host schema drift.

Historical product abbreviations are not database ownership namespaces. The `sr_` table prefix is prohibited for current schema; legacy tables are migrated, re-homed, or removed according to data/ownership evidence rather than mechanically renamed. Historical migrations may still reference legacy identifiers for transition logic, while Canon030 proves convergence to current metadata.

Plurality, SQL reserved-word handling, FK semantics, and identifier-type strategy remain outside Canon054 pending separate evidence/exception contracts.

Amendment 2026-09-23: reusable system-field ownership remains with the defining component. Objecting now supplies deterministic table-level identity constraints through an Objecting-owned Doctrine metadata listener, producing names such as `uniq_<table>_uuid` and `uniq_<table>_slug` without consumer duplication. Doctrine hash-derived application constraint/index names are migration debt rather than the intended current contract; column-level `unique: true` must not be used when it delegates physical constraint naming to Doctrine. Standalone Objecting identity consumers activate `App\\Objecting\\ObjectBundle`; bundle-only consumers inherit that activation from the composing Host.

## 2026-09-22 — Closed sibling Composer symlink contour

Materialized rule: Canon053.

Canonical component development now treats sibling Composer symlinks as a closed contour rather than a growing allow-list of platform capabilities. Only Gating, Cruding, Viewing, and Interfacing may be exposed through sibling `path` repositories with `options.symlink: true`. Any newly introduced component is therefore isolated by default without requiring Gating to know its name.

Canon053 is intentionally narrow: it checks only the existence of prohibited sibling Composer symlinks. It does not require the four exceptions to be installed, infer architectural roles, inspect PHP references, or analyze the Symfony container. Those concerns remain independent rules.

## 2026-09-05 — First consolidated architecture batch

Status: accepted for materialization.

Evidence was consolidated from repeated component-repository reviews including Faceting, Facting, Casing, Complying, Cruding, and related platform components. The batch also reconciles existing local Canonization guidance with newer cross-repository findings.

Materialized rules: Canon000 through Canon010, with `Rule` as the terminal technical-role token on both Canonization and Gating sides.

Important consolidation decisions:

- `Contract/` is not globally forbidden, but may not be used as a generic dumping ground when a clearer typed interface role exists.
- `Entity/<Component>/` is the only currently accepted early component-folder depth exception because Doctrine mappings, entity managers, aliases, and multiple DB connections can require it.
- Component names ending in `-ing` are not mechanically stemmed. Platform vocabulary controls the PHP subject prefix.
- `Gating` is executable enforcement of the canon, not a competing normative source.
- Historical Federation/Orchestration sketch archives may provide evidence but do not override current normative rules.

## 2026-09-05 — First batch executable debt closure

Canon000 through Canon010 now have mirrored executable PHP rules in Gating under `src/Rule/Canon/`. Gating also has `CanonRuleMirrorRule`, which verifies that local sibling Canonization rule documents have matching `CanonNNN<SemanticName>Rule.php` implementations.

Validation completed successfully: changed-PHP lint, calibration tests, PHPStan, and the full Gating gate all pass.

Profile-dependent semantic rules intentionally return `skipped` when their required vocabulary, dependency, boundary, or migration inputs are not declared rather than guessing.

Closing the first batch also exposed and corrected two existing Gating topology violations: `RoutePolicy` moved into the `Policy/Route` role tree and `GatingRunner` into the `Runner` role tree.

## 2026-09-05 — Second owner-canon batch

Materialized rules: Canon011 through Canon017.

This batch intentionally excludes commodity formatting, ordinary unused-code checks, and standard analyzable type defects that are already owned by PHP-CS-Fixer/PHPCS/PHPStan/Rector-class tooling. Canonization admits a rule only when it defines platform-specific architecture, topology, ownership, lifecycle, or semantic behavior beyond those standard tools.

The batch covers observable failures, typed internal boundaries, production placeholder readiness, executable responsibility, tooling/runtime separation, compatibility lifecycle, and documentation/runtime consistency.

All seven rules have mirrored Gating implementations. Hard deterministic patterns fail; semantic heuristics warn; rules that require repository-specific vocabulary or stale-token knowledge are profile-gated rather than guessed.

## 2026-09-05 — Third owner/Symfony architecture batch

Materialized rules: Canon018 through Canon022.

The batch was deliberately narrowed before materialization. Earlier proposals for CLI ownership, route ownership, Host integration orchestration, DI integration ownership, Entity-first persistence, and Symfony extension-point ownership were not accepted and are not part of the canon.

Canon018 makes `composer.json:name` an executable identity contract: `<component-token>/<subject-token>` maps the first token to `App\\<ComponentToken>\\ => src/` and the second token to the PHP subject prefix. The subject token is not inferred by trimming `-ing`.

Canon021 keeps generic application CRUD in `cruding/crud`, while explicitly allowing EasyAdmin CRUD controllers/routes for standalone back-office/admin surfaces. Canon022 keeps `enveloping/envelope` explicitly outside the mandatory standalone baseline as an optional Host-composed execution-context capability; consumer components remain valid without it. Canon022 requires standalone Symfony applications to declare direct runtime dependencies on `cruding/crud`, `viewing/view`, `interfacing/interface`, `objecting/object`, and `easycorp/easyadmin-bundle`; standalone status is detected from Symfony boot surfaces rather than Composer `type`.

## 2026-09-05 — Environment, runtime, version and database stack batch

Materialized rules: Canon023 through Canon028.

Development and production dependency resolution are intentionally different. `composer.json` is the development manifest and local sibling first-party packages use Composer `path` repositories with `symlink: true`. `composer.prod.json` is the production/container-build manifest and must resolve packaged dependencies without sibling path/symlink repositories.

Components remain dual-mode: self-bootable Symfony applications for build, verification, testing and debugging, and reusable Symfony bundles for Host composition.

The platform version floor is PHP 8.4+ and Symfony 8.1+ within Symfony 8.x. The Symfony minor floor is deliberately movable as the maintained 8.x baseline advances.

The canonical relational engine stack is PostgreSQL plus SQLite. PostgreSQL is the primary/data engine and SQLite the file-backed infrastructure/system engine. This batch declares engine and connection-role topology only; detailed ownership of menus, comments, messages, social metadata, or other entity families remains outside this rule set for now.

Amendment 2026-09-09: the original materialization incorrectly named MySQL as the canonical infrastructure/system engine. Canon027 and Canon028 are corrected to the intended PostgreSQL + SQLite topology, with canonical Doctrine drivers `pdo_pgsql` and `pdo_sqlite`.

## 2026-09-05 — Mandatory PHP quality tooling

Materialized rule: Canon029.

Canon029 enforces the presence and executable integration of the standard quality tools that remain responsible for commodity code-quality concerns: `friendsofphp/php-cs-fixer` and `phpstan/phpstan` must be development dependencies, each tool must have repository-owned configuration, and Composer scripts must expose runnable fixer and static-analysis commands. This preserves the admission boundary: Canonization requires the tooling contract but does not duplicate the tools' own formatting or static-analysis rule sets.

## 2026-09-05 — Doctrine Entity/migration schema parity

Materialized rule: Canon030.

Doctrine Entity mapping/metadata is the relational schema source of truth. The complete migration chain must reproduce the current metadata schema from a clean database, and after migrations there must be no remaining Doctrine schema diff. Gating itself does not recreate a developer database destructively; it verifies that ORM+migrations repositories expose an executable schema-parity contract using `doctrine:schema:validate` plus migration-currentness/diff verification suitable for an isolated or disposable database in CI/container validation.

## 2026-09-05 — PHPDoc coverage warning gate

Materialized rule: Canon031.

Classes and methods are measured separately. A PHPDoc block counts as covered only when it contains a minimally meaningful human-readable description; tags alone do not count. The executable threshold is at least five words and 30 non-markup characters, with obvious placeholders rejected. Coverage below 70% in either class or method category produces a warning and representative weak symbols for semantic follow-up by ChatGPT/agent execution. Gating deliberately does not judge full correctness or freshness of prose.

## 2026-09-06 — Bundle, manifest identity, ignore baseline, and Symfony container reuse

Materialized rules: Canon032 through Canon035.

Canon032 requires the reusable component Bundle to be actually registered by standalone mode; component-specific bundle config files are valid and the filename itself is not canonical. Canon033 keeps `composer.json` and `composer.prod.json` aligned on package identity, PSR-4 identity, and PHP/Symfony platform baseline while explicitly allowing different dependency sets and environment-specific repositories/scripts. Canon034 evaluates `.gitignore` quality by coverage category rather than one literal template: absence is a failure and incomplete categories warn. Canon035 states the performance/runtime invariant that unchanged HTTP requests reuse a stable Symfony compiled-container/cache identity; request-time cache clear/warmup, Kernel reboot, hardcoded dev/debug runtime, or request/time/random-derived cache identity are non-canonical. A two-request container probe remains an ordinary validation operation rather than a Canon rule.

## 2026-09-09 — Documentation producer ownership

Materialized rule: Canon036.

Ordinary component repositories are documentation producers rather than independent Antora site owners. Repository-facing Markdown remains valid, and Antora-compatible AsciiDoc belongs under the component `docs/` producer surface such as `docs/antora.yml` and `docs/modules/ROOT/**`. The central Antora playbook, UI/assets, aggregation, publishing workflow, and publication ownership belong to Documentating.

Canon036 also records the semantic anti-drift rule: Markdown and AsciiDoc must not become two independently maintained peer copies of the same narrative. Thin wrappers/includes are valid where one surface is canonical. Gating enforces only deterministic site-ownership topology and does not hard-fail semantic content similarity.

## 2026-09-11 — PHPUnit tooling and executable coverage adequacy

Materialized rules: Canon039 and Canon040.

Canon039 makes PHPUnit/php-code-coverage the standard executable testing contract for canonical PHP repositories. Repositories with executable production PHP code declare `phpunit/phpunit`, own PHPUnit configuration, explicitly include production source in the coverage population, preserve uncovered files in that population, enable branch instrumentation, and expose Composer execution paths for ordinary tests and persistent standard text coverage summaries. Canonization deliberately does not duplicate PHPUnit's own execution or collection logic.

Canon040 defines independent executable-coverage targets: line coverage >=80%, method/function coverage >=80%, and branch coverage >=70%. No metric may mask debt in another. Test counts are expressly non-normative: the number of test methods/classes/files relative to production methods/classes/files is diagnostic information only and is not a quality gate.

Coverage below target is warning-level remediation debt so the ecosystem can adopt the new standard incrementally. Coverage below 50% line, 50% method/function, or 40% branch is classified as `HIGH_TEST_DEBT` and may be admitted to an automated remediation queue. Queue priority remains an engine concern rather than a Canon rule.

The canonical measurement source is the persistent PHPUnit/php-code-coverage text summary. Gating must require `Lines`, `Methods`, and `Branches` counters from that tool-owned report instead of approximating coverage with source/test counting heuristics.

## 2026-09-12 — Functional, browser, and UI testing contract

Materialized rules: Canon041 and Canon042.

Canon041 extends the executable testing baseline for standalone Symfony applications. `symfony/test-pack` provides the standard Symfony application-testing stack, `symfony/panther` provides real-browser Symfony end-to-end testing, and `@playwright/test` provides repository-local UI/browser testing. The rule requires dependencies, Playwright configuration, and reproducible repository execution scripts rather than relying on globally installed tooling.

Canon042 deliberately separates behavioral/UI coverage from Canon040 PHP executable coverage. Passing test counts are not treated as coverage. Instead, a repository-owned coverage producer must write explicit `covered`/`total` counters for functional application surfaces, behavioral workflows, interactive UI surfaces, and critical workflows to `var/coverage/behavioral-ui.json`. Gating consumes those counters but does not infer denominators from test files, routes, controllers, or Playwright spec counts.

Initial targets are functional >=80%, behavioral >=80%, UI >=70%, and critical workflow coverage =100%. `HIGH_BEHAVIORAL_TEST_DEBT` is raised below 50% functional, 50% behavioral, 40% UI, or whenever critical workflow coverage is below 100%. Missing, stale, or invalid evidence is warning-level debt so repositories can be brought into compliance incrementally.

## 2026-09-13 — Objecting system-field naming boundary

Materialized rule: Canon044.

Objecting ownership vocabulary and persisted field vocabulary are now explicitly separated. Logical field-pack identifiers and reusable PHP ownership types retain `object_*` / `Object*` names, while Doctrine-mapped system fields and physical database columns use flat entity-native names such as `created_at`, `uuid`, `status`, and `version`. `object_*`, `objecting_*`, `$object...`, and `$objecting...` field names are non-canonical in both `objecting/object` itself and its Composer consumers.

Historical migrations, archives, schema mirrors, generated artifacts, or previous implementations do not authorize restoration of prefixed active fields. Gating provides the executable hard check for current Doctrine mapping.

## 2026-09-13 — Canon031/Canon042 denominator calibration

Canon031 was narrowed from all named methods to contract-significant public/protected behavior. Private helpers, PHP magic methods, constructors/destructors, and conventional `get*`/`set*`/`is*`/`has*` accessors are excluded from the method denominator and reported separately. This prevents the rule from rewarding ceremonial comments on self-describing accessors while preserving the 70% requirement for classes and meaningful callable contracts.

Canon042 moved from trusted `covered`/`total` counters to `behavioral-ui-coverage-v2`. A repository-owned Composer/npm script now identifies itself as the evidence producer; each dimension publishes explicit `eligible` and `covered` stable identifiers plus `generatedAt`. Gating derives percentages from those inventories, rejects duplicate/out-of-denominator claims, rejects undeclared producers, and treats legacy counter-only JSON as unverifiable warning-level evidence.
