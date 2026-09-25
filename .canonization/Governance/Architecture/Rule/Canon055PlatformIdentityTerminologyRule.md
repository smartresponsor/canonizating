# Canon055PlatformIdentityTerminologyRule — Consumer Identity Must Not Masquerade as Platform Identity

## Identity

Canon: `Canon055`
Gating mirror: `Canon055PlatformIdentityTerminologyRule.php`

## Requirement

The system is a multi-domain SaaS platform. A consumer/domain identity must not be promoted into the identity of the platform, the project as a whole, the architecture canon, the repository family, or the shared component/service ecosystem.

The names `Smart Responder`, `Smart Responsor`, and `SmartResponsor` identify one consumer/domain only. They are not canonical names for the platform or for its shared architecture.

Current human-facing documentation, repository descriptions, manifests, package descriptions, architecture text, and agent-facing instructions MUST use neutral platform vocabulary such as `platform`, `multi-domain SaaS platform`, `component`, `repository`, `service`, `application`, or `consumer` according to the actual subject.

## Allowed

- an explicit statement about that specific consumer/domain, where the text clearly identifies it as a consumer/domain rather than the platform;
- machine identity that is not human-facing product/platform naming, including an existing GitHub owner, Composer vendor/package name, schema identifier, URL host, or equivalent technical locator;
- historical records, changelogs, migration evidence, and this rule's own normative alias declaration when the historical or definitional context is explicit.

## Prohibited

- using any of the consumer aliases as the platform or project name;
- phrases such as a consumer alias followed by `platform`, `architecture`, `canon`, `repositories`, `components`, `services`, or equivalent ecosystem-wide ownership language;
- describing shared platform rules, dependencies, runtime contracts, database policy, or repository families as belonging to that consumer;
- human-facing package/repository descriptions that present that consumer as the owner identity of the whole platform.

## Rationale

The platform is multi-domain. Reusing one consumer identity as the umbrella identity collapses the platform/consumer boundary, leaks one domain into unrelated components, and teaches humans and agents an incorrect ownership model. Technical locators may retain historical identifiers without granting those identifiers product or architectural authority.

## Guardability

Composite. Gating deterministically scans current human-facing documentation and selected human-facing package metadata for the aliases. A hit fails unless its local text explicitly frames the alias as a consumer/domain. Machine identifiers are not scanned as branding. Historical records and the Canon055 normative definition are excluded from the hard failure contour.

The gate is detection-only. It MUST NOT rewrite prose automatically; remediation belongs to the working agent/chat because a replacement must preserve the sentence's actual subject.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "current human-facing Markdown/AsciiDoc/reStructuredText documentation plus human-facing Composer package description"
  extraction: [file_path, line_number, matching_alias, local_line_text, explicit_consumer_or_domain_context]
  body_read: candidates_only
  reasoning: candidates_only
  escalation: [alias_hit_without_explicit_consumer_context, ambiguous_historical_status, repository_metadata_outside_worktree]
  executable_evidence: ["Gating Canon055 findings"]
```
