#requires -Version 5.1
<#
.SYNOPSIS
  Link this claude-config repo's portable assets into ~/.claude so Claude Code picks them up.
.DESCRIPTION
  Idempotent. Symlinks the global skills, global CLAUDE.md, and output-style from this repo into
  the user's ~/.claude directory (falling back to a copy if symlink privilege is unavailable), and
  ensures settings.json selects the output style without clobbering other keys.

  Secrets (.credentials.json, tokens) are NEVER touched and NEVER live in this repo -- on a new
  machine you re-authenticate locally with `claude` as usual.
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\install.ps1
#>
[CmdletBinding()]
param(
  [string]$ClaudeHome = (Join-Path $env:USERPROFILE '.claude')
)
$ErrorActionPreference = 'Stop'
$Root = $PSScriptRoot

function Remove-LinkOnly {
  # Delete a symlink without recursing into (and destroying) its target.
  param([System.IO.FileSystemInfo]$Item)
  if ($Item.PSIsContainer) { [System.IO.Directory]::Delete($Item.FullName, $false) }
  else { [System.IO.File]::Delete($Item.FullName) }
}

function Link-Item {
  param([string]$LinkPath, [string]$TargetPath)
  $parent = Split-Path -Parent $LinkPath
  if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }

  if (Test-Path $LinkPath) {
    $existing = Get-Item $LinkPath -Force
    if ($existing.LinkType -eq 'SymbolicLink') {
      Remove-LinkOnly $existing
    } else {
      $bak = "$LinkPath.bak"
      if (Test-Path $bak) { Remove-Item $bak -Recurse -Force }
      Move-Item $LinkPath $bak
      Write-Host "  backed up existing real item -> $bak"
    }
  }

  try {
    New-Item -ItemType SymbolicLink -Path $LinkPath -Target $TargetPath -ErrorAction Stop | Out-Null
    Write-Host "  linked   $LinkPath"
  } catch {
    Write-Warning "  symlink failed ($($_.Exception.Message)); copying instead"
    if ((Get-Item $TargetPath).PSIsContainer) { Copy-Item $TargetPath $LinkPath -Recurse -Force }
    else { Copy-Item $TargetPath $LinkPath -Force }
  }
}

Write-Host "Installing claude-config"
Write-Host "  from: $Root"
Write-Host "  into: $ClaudeHome"
Write-Host ""

Link-Item (Join-Path $ClaudeHome 'skills\retro')                  (Join-Path $Root 'skills\retro')
Link-Item (Join-Path $ClaudeHome 'skills\design-direction')       (Join-Path $Root 'skills\design-direction')
Link-Item (Join-Path $ClaudeHome 'CLAUDE.md')                     (Join-Path $Root 'CLAUDE.md')
Link-Item (Join-Path $ClaudeHome 'output-styles\baby-fable-5.md') (Join-Path $Root 'output-styles\baby-fable-5.md')

# Select the output style without disturbing any other (possibly secret) settings keys.
$settingsPath = Join-Path $ClaudeHome 'settings.json'
if (Test-Path $settingsPath) {
  $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json
} else {
  $settings = [pscustomobject]@{}
}
$settings | Add-Member -NotePropertyName 'outputStyle' -NotePropertyValue 'baby-fable-5' -Force
# Write UTF-8 WITHOUT BOM -- Node's JSON.parse (used by Claude Code) throws on a leading BOM.
$json = $settings | ConvertTo-Json -Depth 20
[System.IO.File]::WriteAllText($settingsPath, $json, (New-Object System.Text.UTF8Encoding($false)))
Write-Host "  set outputStyle=baby-fable-5 in settings.json"

Write-Host ""
Write-Host "Done. Start a new Claude Code session to pick up the global skills + output style."
Write-Host "(.bak files are your old real copies -- delete them once you've confirmed things work.)"
