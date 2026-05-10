# AI Agent Skills Library - Windows PowerShell installer
#
# Usage:
#   iwr -useb https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.ps1 | iex
#   & ([scriptblock]::Create((iwr -useb ...))) -Skill newsletter-drafter
#   & ([scriptblock]::Create((iwr -useb ...))) -Bundle codex-essentials
#   & ([scriptblock]::Create((iwr -useb ...))) -Search "business model"
#   & ([scriptblock]::Create((iwr -useb ...))) -List
#   & ([scriptblock]::Create((iwr -useb ...))) -DryRun -Bundle agent-foundation
#   & ([scriptblock]::Create((iwr -useb ...))) -Tool codex -Scope project -Force -Skill newsletter-drafter

param(
    [string[]]$Skill = @(),
    [ValidateSet("", "project", "global")]
    [string]$Scope = "",
    [ValidateSet("", "claude-code", "cursor", "codex", "windsurf", "opencode", "antigravity")]
    [string]$Tool = "",
    [string]$Bundle = "",
    [string]$Category = "",
    [string]$Search = "",
    [switch]$List,
    [switch]$Bundles,
    [switch]$Categories,
    [switch]$DryRun,
    [switch]$Force,
    [switch]$Update,
    [switch]$All
)

$ErrorActionPreference = "Stop"
$RepoUrl = if ($env:REPO_URL) { $env:REPO_URL } else { "https://github.com/newmindsgroup/ai-agent-skills-library" }
$TarUrl  = if ($env:TARBALL_URL) { $env:TARBALL_URL } else { "$RepoUrl/archive/refs/heads/main.zip" }

function Info($m) { Write-Host "[info] $m" -ForegroundColor Cyan }
function Ok($m)   { Write-Host "[ ok ] $m" -ForegroundColor Green }
function Warn($m) { Write-Host "[warn] $m" -ForegroundColor Yellow }
function Err($m)  { Write-Host "[err ] $m" -ForegroundColor Red }

if ($Update) {
    $Force = $true
}

function Get-ArchiveRoot($tmp) {
    $roots = @(Get-ChildItem $tmp -Directory -Recurse | Where-Object {
        Test-Path (Join-Path $_.FullName "dist\skills")
    })
    if ($roots.Count -gt 0) {
        return $roots[0].FullName
    }

    $legacy = @(Get-ChildItem $tmp -Directory -Recurse | Where-Object {
        Test-Path (Join-Path $_.FullName "skills")
    })
    if ($legacy.Count -gt 0) {
        return $legacy[0].FullName
    }

    return $null
}

function Read-IndexRows($indexTsv) {
    if (-not (Test-Path $indexTsv)) {
        return @()
    }
    return @(Import-Csv -Path $indexTsv -Delimiter "`t")
}

function List-Skills($rows, $srcDir) {
    if ($rows.Count -gt 0) {
        $rows | Sort-Object name | ForEach-Object {
            "{0,-36} {1,-38} {2}" -f $_.name, $_.category, $_.description
        }
    } else {
        Get-ChildItem $srcDir -Directory | Sort-Object Name | Select-Object -ExpandProperty Name
    }
}

function List-Categories($rows) {
    if ($rows.Count -eq 0) {
        Warn "Category index not available in this archive."
        return
    }
    $rows | Group-Object category | Sort-Object Count -Descending | ForEach-Object {
        "{0,5}  {1}" -f $_.Count, $_.Name
    }
}

function List-Bundles($bundlesDir) {
    if (-not (Test-Path $bundlesDir)) {
        Warn "Bundle index not available in this archive."
        return
    }
    Get-ChildItem $bundlesDir -Filter "*.txt" | Sort-Object Name | ForEach-Object {
        $count = (Get-Content $_.FullName | Where-Object { $_.Trim() -ne "" }).Count
        "{0,-28} {1} skills" -f $_.BaseName, $count
    }
}

function Search-Skills($rows, $query, $srcDir) {
    $needle = $query.ToLowerInvariant()
    if ($rows.Count -gt 0) {
        $rows | Where-Object {
            ($_.name + " " + $_.category + " " + $_.source_slug + " " + $_.source_label + " " + $_.trust_level + " " + $_.bundles + " " + $_.description).ToLowerInvariant().Contains($needle)
        } | Sort-Object name | ForEach-Object {
            "{0,-36} {1,-38} {2}" -f $_.name, $_.category, $_.description
        }
    } else {
        Get-ChildItem $srcDir -Directory | Where-Object { $_.Name -like "*$query*" } | Sort-Object Name | Select-Object -ExpandProperty Name
    }
}

function Skills-ForCategory($rows, $category) {
    if ($rows.Count -eq 0) {
        throw "Category filtering requires dist\skills-index.tsv."
    }
    return @($rows | Where-Object { $_.category -eq $category } | Sort-Object name | Select-Object -ExpandProperty name)
}

function Skills-ForBundle($bundlesDir, $bundle) {
    $bundleFile = Join-Path $bundlesDir "$bundle.txt"
    if (-not (Test-Path $bundleFile)) {
        Err "Unknown bundle: $bundle"
        Info "Available bundles:"
        List-Bundles $bundlesDir
        exit 1
    }
    return @(Get-Content $bundleFile | Where-Object { $_.Trim() -ne "" })
}

# Download
$tmp = Join-Path $env:TEMP ("ai-skills-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $tmp | Out-Null
$zipPath = Join-Path $tmp "main.zip"
Info "Downloading skills archive..."
Invoke-WebRequest -Uri $TarUrl -OutFile $zipPath -UseBasicParsing
Expand-Archive -Path $zipPath -DestinationPath $tmp -Force

$archiveRoot = Get-ArchiveRoot $tmp
if (-not $archiveRoot) {
    Err "Could not locate dist\skills in archive."
    exit 1
}

$srcDir = Join-Path $archiveRoot "dist\skills"
if (-not (Test-Path $srcDir)) {
    $srcDir = Join-Path $archiveRoot "skills"
}
if (-not (Test-Path $srcDir)) {
    Err "Could not locate installable skills in archive."
    exit 1
}

$indexTsv = Join-Path $archiveRoot "dist\skills-index.tsv"
$bundlesDir = Join-Path $archiveRoot "dist\bundles"
$rows = Read-IndexRows $indexTsv

if ($Categories) {
    Write-Host ""
    Write-Host "Categories"
    List-Categories $rows
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
    exit 0
}

if ($Bundles) {
    Write-Host ""
    Write-Host "Starter packs"
    List-Bundles $bundlesDir
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
    exit 0
}

if ($List) {
    Write-Host ""
    Write-Host "Skills"
    List-Skills $rows $srcDir
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
    exit 0
}

if ($Search -and $Skill.Count -eq 0 -and -not $Bundle -and -not $Category) {
    Write-Host ""
    Write-Host "Search results for `"$Search`""
    Search-Skills $rows $Search $srcDir
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
    exit 0
}

$skills = @()
if ($Bundle) {
    $skills += Skills-ForBundle $bundlesDir $Bundle
}
if ($Category) {
    $skills += Skills-ForCategory $rows $Category
}
if ($Skill.Count -gt 0) {
    $skills += $Skill
}
if ($skills.Count -eq 0) {
    if (-not $All) {
        Warn "No skill, bundle, or category selected. Installing the full library for backward compatibility."
        Warn "For a smaller setup, use -Bundle codex-essentials or run -Bundles to see starter packs."
    }
    $skills = Get-ChildItem $srcDir -Directory | Sort-Object Name | Select-Object -ExpandProperty Name
}

$skills = @($skills | Where-Object { $_.Trim() -ne "" } | Select-Object -Unique)
foreach ($s in $skills) {
    if (-not (Test-Path (Join-Path $srcDir $s))) {
        Err "Skill not found: $s"
        Info "Try -Search `"$s`" or -List."
        exit 1
    }
}

Info "Skills selected: $($skills.Count)"
if ($skills.Count -le 30) {
    $skills | ForEach-Object { Write-Host "  - $_" }
}

# Detect tools
function Detect-Tools {
    $found = @()
    if (Test-Path ".claude")   { $found += "claude-code:project" }
    if (Test-Path ".cursor")   { $found += "cursor:project" }
    if (Test-Path "AGENTS.md") { $found += "codex:project" }
    if (Test-Path ".codex")    { $found += "codex:project" }
    if (Test-Path ".windsurf") { $found += "windsurf:project" }
    if (Test-Path ".opencode") { $found += "opencode:project" }
    if (Test-Path ".agent")    { $found += "antigravity:project" }

    if ($found.Count -eq 0) {
        if (Test-Path "$env:USERPROFILE\.claude")            { $found += "claude-code:global" }
        if (Test-Path "$env:USERPROFILE\.cursor")            { $found += "cursor:global" }
        if (Test-Path "$env:USERPROFILE\.codex")             { $found += "codex:global" }
        if (Test-Path "$env:APPDATA\opencode")               { $found += "opencode:global" }
        if (Test-Path "$env:USERPROFILE\.gemini\antigravity") { $found += "antigravity:global" }
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

if ($DryRun) {
    Write-Host ""
    Write-Host "Dry run"
    foreach ($t in $tools) {
        $parts = $t -split ":"
        $toolName = $parts[0]
        $toolScope = if ($Scope) { $Scope } else { $parts[1] }
        $dest = Target-Dir $toolName $toolScope
        Info "Would install $($skills.Count) skill(s) into $toolName ($toolScope) at $dest"
    }
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
    exit 0
}

$count = 0
foreach ($t in $tools) {
    $parts = $t -split ":"
    $toolName = $parts[0]
    $toolScope = if ($Scope) { $Scope } else { $parts[1] }
    $dest = Target-Dir $toolName $toolScope
    if (-not $dest) { Warn "Unknown tool: $toolName"; continue }

    Write-Host ""
    Info "Installing into $toolName ($toolScope) -> $dest"
    New-Item -ItemType Directory -Path $dest -Force | Out-Null
    foreach ($s in $skills) {
        $target = Join-Path $dest $s
        if (Test-Path $target) {
            if ($Force) {
                Remove-Item $target -Recurse -Force
            } else {
                Warn "  $s already exists, skipping. Use -Force or -Update to reinstall."
                continue
            }
        }
        Copy-Item (Join-Path $srcDir $s) $target -Recurse
        Ok "  Installed $s"
        $count++
    }

    if ($toolName -eq "codex" -and $toolScope -eq "project" -and -not (Test-Path "AGENTS.md")) {
        $lines = @(
            "# AGENTS.md",
            "",
            "This project uses the AI Agent Skills Library ($RepoUrl).",
            "",
            'Skills live in `skills/`. Each skill is a folder with a `SKILL.md` file and optional `references/`, `scripts/`, and `assets/` directories. Apply the skill''s instructions when the user''s request matches the skill''s description.',
            "",
            "## Installed skills",
            ""
        )
        foreach ($s in $skills) {
            $lines += "- [``$s``](skills/$s/SKILL.md)"
        }
        $lines += ""
        $lines += 'Read each skill''s `SKILL.md` frontmatter to know when to trigger it.'
        Set-Content -Path "AGENTS.md" -Value $lines -Encoding UTF8
        Ok "  Wrote AGENTS.md"
    }
}

Write-Host ""
Ok "$count skill(s) installed."
if ($Update) {
    Info "Update mode was enabled; existing selected skills were refreshed."
}
Info "Restart your IDE for skills to load."
Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
