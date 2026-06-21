#requires -Version 5.1
<#
.SYNOPSIS
  Give a project repo the per-project design "content" the global design-direction skill needs.
.DESCRIPTION
  The retro/loop mechanism needs NO per-repo setup -- AGENTS.md is already its sink and the global
  CLAUDE.md rule drives capture, so it's active in every repo the moment claude-config is installed
  on the machine. The only thing a NEW repo may need is design *content*:
    - a Design pointer in AGENTS.md (so DESIGN.md is discoverable without invoking the skill)
    - a DESIGN.md brand contract (only if the repo has a UI / design surface)
  This adds both, idempotently. It drops a TEMPLATE DESIGN.md -- fill it from the repo's real tokens
  (fastest: open the repo in Claude Code and say "fill in DESIGN.md from our tokens").
.PARAMETER RepoPath
  Path to the target repo root (where AGENTS.md lives / should live).
.PARAMETER NoDesignFile
  Skip the DESIGN.md template -- use for backend / no-UI repos. (Such repos need nothing for the
  loop, which is already global, so you can usually skip this script entirely for them.)
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\bootstrap-repo.ps1 -RepoPath D:\my-new-app
.EXAMPLE
  powershell -File .\bootstrap-repo.ps1 -RepoPath D:\api-only -NoDesignFile
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)][string]$RepoPath,
  [switch]$NoDesignFile
)
$ErrorActionPreference = 'Stop'
$Root = $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)   # no BOM -- keeps markdown/JSON clean

if (-not (Test-Path -LiteralPath $RepoPath)) { throw "Repo path not found: $RepoPath" }
$RepoPath = (Resolve-Path -LiteralPath $RepoPath).Path
$agents = Join-Path $RepoPath 'AGENTS.md'
$design = Join-Path $RepoPath 'DESIGN.md'

$pointerBlock = @'
<!-- BEGIN:design-contract -->
# Design

Visual work follows `DESIGN.md` (the binding brand contract: palette, type, surfaces, do/don't,
constraints). Read it before designing any UI. The global `design-direction` skill applies it and
offers directions when a brief is open.
<!-- END:design-contract -->
'@

# --- AGENTS.md: ensure the Design pointer is present (idempotent) ---
if (-not (Test-Path -LiteralPath $agents)) {
  [System.IO.File]::WriteAllText($agents, "# Agent onboarding`r`n`r`n$pointerBlock`r`n", $utf8)
  Write-Host "created  AGENTS.md (+ Design pointer)"
} else {
  $existing = [System.IO.File]::ReadAllText($agents)
  if ($existing -match 'BEGIN:design-contract') {
    Write-Host "skip     AGENTS.md already has a Design pointer"
  } else {
    $sep = if ($existing.EndsWith("`n")) { "`r`n" } else { "`r`n`r`n" }
    [System.IO.File]::AppendAllText($agents, "$sep$pointerBlock`r`n", $utf8)
    Write-Host "updated  AGENTS.md (appended Design pointer)"
  }
}

# --- DESIGN.md: drop the template if wanted and absent ---
if ($NoDesignFile) {
  Write-Host "skip     DESIGN.md (-NoDesignFile)"
} elseif (Test-Path -LiteralPath $design) {
  Write-Host "skip     DESIGN.md already exists"
} else {
  Copy-Item -LiteralPath (Join-Path $Root 'templates\DESIGN.md') -Destination $design
  Write-Host "created  DESIGN.md (template -- fill from your tokens)"
}

Write-Host ""
Write-Host "Next: open this repo in Claude Code and say 'fill in DESIGN.md from our tokens' --"
Write-Host "design-direction reads the real globals.css/theme and replaces the placeholders."
Write-Host "The retro/loop mechanism is already active here (global); nothing to install for it."
