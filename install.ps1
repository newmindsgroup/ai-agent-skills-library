# AI Agent Skills Library — Windows PowerShell installer
#
# Usage:
#   iwr -useb https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.ps1 | iex
#   & ([scriptblock]::Create((iwr -useb ...))) -Skill institutional-ai-operating-principles
#   & ([scriptblock]::Create((iwr -useb ...))) -Scope global
#   & ([scriptblock]::Create((iwr -useb ...))) -Tool cursor

param(
    [string]$Skill = "",
    [ValidateSet("", "project", "global")]
    [string]$Scope = "",
    [ValidateSet("", "claude-code", "cursor", "codex", "windsurf", "opencode", "antigravity")]
    [string]$Tool = ""
)

$ErrorActionPreference = "Stop"
$RepoUrl = if ($env:REPO_URL) { $env:REPO_URL } else { "https://github.com/newmindsgroup/ai-agent-skills-library" }
$TarUrl  = if ($env:TARBALL_URL) { $env:TARBALL_URL } else { "$RepoUrl/archive/refs/heads/main.zip" }

function Info($m) { Write-Host "[info] $m" -ForegroundColor Cyan }
function Ok($m)   { Write-Host "[ ok ] $m" -ForegroundColor Green }
function Warn($m) { Write-Host "[warn] $m" -ForegroundColor Yellow }
function Err($m)  { Write-Host "[err ] $m" -ForegroundColor Red }

# Download
$tmp = Join-Path $env:TEMP ("ai-skills-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $tmp | Out-Null
$zipPath = Join-Path $tmp "main.zip"
Info "Downloading skills archive..."
Invoke-WebRequest -Uri $TarUrl -OutFile $zipPath -UseBasicParsing
Expand-Archive -Path $zipPath -DestinationPath $tmp -Force
$srcRoot = Get-ChildItem $tmp -Directory | Where-Object { $_.Name -like "ai-agent-skills-library-*" } | Select-Object -First 1
$srcDir = Join-Path $srcRoot.FullName "dist\skills"
if (-not (Test-Path $srcDir)) {
    $srcDir = Join-Path $srcRoot.FullName "skills"
}
if (-not (Test-Path $srcDir)) {
    Err "Could not locate dist\skills in archive."
    exit 1
}

# Determine skills to install
if ($Skill) {
    if (-not (Test-Path (Join-Path $srcDir $Skill))) { Err "Skill not found: $Skill"; exit 1 }
    $skills = @($Skill)
} else {
    $skills = Get-ChildItem $srcDir -Directory | Select-Object -ExpandProperty Name
}
Info ("Skills to install: " + ($skills -join ", "))

# Detect tools
function Detect-Tools {
    $found = @()
    if (Test-Path ".claude")   { $found += "claude-code:project" }
    if (Test-Path ".cursor")   { $found += "cursor:project" }
    if (Test-Path "AGENTS.md") { $found += "codex:project" }
    if (Test-Path ".windsurf") { $found += "windsurf:project" }
    if (Test-Path ".opencode") { $found += "opencode:project" }
    if (Test-Path ".agent")    { $found += "antigravity:project" }

    if ($found.Count -eq 0) {
        if (Test-Path "$env:USERPROFILE\.claude")           { $found += "claude-code:global" }
        if (Test-Path "$env:APPDATA\opencode")              { $found += "opencode:global" }
        if (Test-Path "$env:USERPROFILE\.gemini\antigravity"){ $found += "antigravity:global" }
    }
    return ($found | Select-Object -Unique)
}

if ($Tool) {
    $effective = if ($Scope) { $Scope } else { "project" }
    $tools = @("${Tool}:${effective}")
} else {
    $tools = Detect-Tools
}

if ($tools.Count -eq 0) {
    Warn "No supported IDE detected. Re-run with -Tool <name> -Scope project|global."
    exit 2
}

Info ("Detected: " + ($tools -join ", "))

function Target-Dir($tool, $scope) {
    switch ("${tool}:${scope}") {
        "claude-code:project" { return ".claude\skills" }
        "claude-code:global"  { return "$env:USERPROFILE\.claude\skills" }
        "cursor:project"      { return ".cursor\skills" }
        "cursor:global"       { return "$env:USERPROFILE\.cursor\skills" }
        "codex:project"       { return "skills" }
        "codex:global"        { return "$env:USERPROFILE\.codex\skills" }
        "windsurf:project"    { return ".windsurf\skills" }
        "windsurf:global"     { return "$env:USERPROFILE\.windsurf\skills" }
        "opencode:project"    { return ".opencode\skills" }
        "opencode:global"     { return "$env:APPDATA\opencode\skills" }
        "antigravity:project" { return ".agent\skills" }
        "antigravity:global"  { return "$env:USERPROFILE\.gemini\antigravity\skills" }
    }
    return $null
}

$count = 0
foreach ($t in $tools) {
    $parts = $t -split ":"
    $tool = $parts[0]; $toolScope = if ($Scope) { $Scope } else { $parts[1] }
    $dest = Target-Dir $tool $toolScope
    if (-not $dest) { Warn "Unknown tool: $tool"; continue }

    Write-Host ""
    Info "Installing into $tool ($toolScope) -> $dest"
    New-Item -ItemType Directory -Path $dest -Force | Out-Null
    foreach ($s in $skills) {
        $target = Join-Path $dest $s
        if (Test-Path $target) { Warn "  $s already exists, skipping"; continue }
        Copy-Item (Join-Path $srcDir $s) $target -Recurse
        Ok "  Installed $s"
        $count++
    }
}

Write-Host ""
Ok "$count skill(s) installed."
Info "Restart your IDE for skills to load."
Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
