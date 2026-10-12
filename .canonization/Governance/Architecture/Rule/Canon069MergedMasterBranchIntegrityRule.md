# Canon069MergedMasterBranchIntegrityRule — Master Integration Required for Canonical GREEN

## Identity
Canon: `Canon069`
Gating mirror: `Canon069MergedMasterBranchIntegrityRule.php`

## Requirement
A repository is not CANONICAL GREEN while any local or fetched remote branch has commits not reachable from `master`. Branch count alone is irrelevant; already-merged branches are allowed.

Inspect all `refs/heads/*` and `refs/remotes/*`, excluding symbolic remote HEAD aliases, using Git ancestry equivalent to `git merge-base --is-ancestor <tip> master`. Clean working tree and passing tests cannot override unmerged commits.

Missing `master`, missing Git metadata, unreadable refs or failed ancestry checks must not produce a passing result. A checked-out non-master branch is not evidence of master quality.

Final ecosystem GREEN additionally requires successful all-remotes fetch/prune provenance before the branch gate and clean master plus passing applicable quality checks. Repository-local Gating must not silently claim to have refreshed the remote: without that provenance, only a local-snapshot result is established.

## Resolution
Inspect divergent commits, semantically review and integrate applicable work through auditable merge/cherry-pick/equivalent. Rejected work must be explicitly adjudicated and retired under governed branch lifecycle. Silently deleting branches or force-moving refs solely to manufacture GREEN is forbidden.

## Guardability
Hard Git-graph invariant; remote freshness and final RC/quality certification are orchestration-owned.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "all local and fetched remote branch refs compared against master"
  extraction: [master_tip, branch_ref, branch_tip, ancestry_status, remote_fetch_provenance]
  body_read: prohibited
  reasoning: none
  escalation: [unmerged_branch, missing_master, git_unavailable, ref_failure, stale_remote_evidence]
  executable_evidence: ["Gating Canon069 ancestry findings", "orchestrator fetch/prune evidence"]
```
