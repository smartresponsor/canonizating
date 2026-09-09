# Canon023DevelopmentComposerSymlinkRule — Development Uses Local Path Symlinks

## Identity

Canon: `Canon023`
Gating mirror: `Canon023DevelopmentComposerSymlinkRule.php`

## Requirement
`composer.json` is the development manifest. Local SmartResponsor component dependencies are declared through Composer `path` repositories pointing at sibling component worktrees, with `options.symlink: true`.

## Prohibited
Do not copy local component sources into a development vendor tree, and do not use `path` repositories with `symlink: false` for canonical local component development.

## Rationale
Development must execute the live sibling worktree so changes are immediately visible across components without repackaging or duplicate source trees.

## Exceptions
Third-party packages and SmartResponsor packages not present as local sibling worktrees may resolve through normal Composer repositories.

## Guardability
Hard for declared local SmartResponsor `path` repositories: each must explicitly enable `symlink: true`.
