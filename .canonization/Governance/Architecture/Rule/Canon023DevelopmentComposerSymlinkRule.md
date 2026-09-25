# Canon023DevelopmentComposerSymlinkRule — Development Uses Local Path Symlinks

## Identity

Canon: `Canon023`
Gating mirror: `Canon023DevelopmentComposerSymlinkRule.php`

## Requirement
`composer.json` is the development manifest. Local first-party component dependencies are declared through Composer `path` repositories pointing at sibling component worktrees, with `options.symlink: true`.

## Prohibited
Do not copy local component sources into a development vendor tree, and do not use `path` repositories with `symlink: false` for canonical local component development.

## Rationale
Development must execute the live sibling worktree so changes are immediately visible across components without repackaging or duplicate source trees.

## Exceptions
Third-party packages and first-party packages not present as local sibling worktrees may resolve through normal Composer repositories.

## Guardability
Hard for declared local first-party `path` repositories: each must explicitly enable `symlink: true`.

## Evidence Contract
```yaml
evidence_contract:
  coverage: "composer.json repositories section only"
  extraction: [repository_type, repository_url, options_symlink]
  body_read: prohibited
  reasoning: none
  escalation: [local_path_repository_shape_invalid]
  executable_evidence: ["Gating Canon023 findings"]
```
