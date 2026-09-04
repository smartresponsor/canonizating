# Copyright (c) 2025 Oleksandr Tishchenko / Marketing America Corp
param(
  [string]$Path = ".",
  [string]$Report = "report/layer-mirror-check.json",
  [switch]$NoWrite
)
$ErrorActionPreference = "Stop"
$root = (Resolve-Path -Path $Path).Path
$arg = @("--path", $root, "--report", $Report)
if ($NoWrite) { $arg += "--no-write" }
$checker = Join-Path (Split-Path $PSScriptRoot -Parent) "js/layer-mirror-check.js"
node $checker @arg
exit $LASTEXITCODE
