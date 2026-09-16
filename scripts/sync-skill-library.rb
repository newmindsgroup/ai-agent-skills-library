#!/usr/bin/env ruby
# Sync the organized source-of-truth skill tree into compatibility exports.
#
# Canonical source tree:
#   sources/<source-slug>/skills/<skill-name>/SKILL.md
#
# Generated compatibility export:
#   dist/skills/<skill-name>/SKILL.md
#
# The export stays flat because most Agent Skills tooling expects
# <skills-root>/<skill-name>/SKILL.md.

require "date"
require "fileutils"
require "json"
require "set"
require "uri"
require "yaml"
require_relative "lib/generated-output"

# Read all files as UTF-8 regardless of the shell locale. Without this, an unset
# locale (LANG/LC_ALL empty) makes Ruby default to US-ASCII, and any non-ASCII
# byte in a skill file raises "invalid byte sequence in US-ASCII".
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

ROOT = File.expand_path("..", __dir__)
SOURCES_DIR = File.join(ROOT, "sources")
EXPORT_DIR = File.join(ROOT, "dist", "skills")
BUNDLES_DIR = File.join(ROOT, "dist", "bundles")
DIST_README = File.join(ROOT, "dist", "README.md")
INDEX_JSON_PATH = File.join(ROOT, "dist", "skills-index.json")
INDEX_TSV_PATH = File.join(ROOT, "dist", "skills-index.tsv")
BUNDLES_JSON_PATH = File.join(ROOT, "dist", "bundles.json")
QUARANTINE_JSON_PATH = File.join(ROOT, "dist", "quarantine-index.json")
QUARANTINE_TSV_PATH = File.join(ROOT, "dist", "quarantine-index.tsv")
MANIFEST_PATH = File.join(ROOT, "manifests", "skills-manifest.json")
STARTER_PACKS_PATH = File.join(ROOT, "manifests", "starter-packs.json")
SOURCE_DOC_PATH = File.join(ROOT, "docs", "SKILL-SOURCES.md")
TRUST_DOC_PATH = File.join(ROOT, "docs", "SKILLS-TRUST.md")
STARTER_PACKS_DOC_PATH = File.join(ROOT, "docs", "STARTER-PACKS.md")
CATALOG_DOC_PATH = File.join(ROOT, "docs", "SKILLS-CATALOG.md")
SAFETY_DOC_PATH = File.join(ROOT, "docs", "SKILLS-SAFETY.md")
SAFETY_POLICY_PATH = File.join(ROOT, "manifests", "skill-safety-policy.json")
GENERATED_SOURCE_MARKER = ".generated-source-index"
GENERATED_EXPORT_MARKER = ".generated-flat-skills"
GENERATED_BUNDLES_MARKER = ".generated-bundles"

def read_frontmatter(path)
  text = File.read(path)
  frontmatter = text.split(/^---\s*$/, 3)[1]
  YAML.safe_load(frontmatter, aliases: true) || {}
rescue StandardError => error
  warn "Could not parse #{path}: #{error.message}"
  {}
end

def normalize_source(raw_source, fallback_slug: nil)
  source = raw_source.to_s.strip
  source = "original" if source.empty? && fallback_slug == "original"
  note = nil

  if source.empty? && fallback_slug
    return {
      "slug" => fallback_slug,
      "label" => fallback_slug,
      "repository" => fallback_slug,
      "url" => nil,
      "type" => "other",
      "note" => nil
    }
  end

  if source == "original"
    return {
      "slug" => "original",
      "label" => "Original New Minds Group",
      "repository" => "Original New Minds Group",
      "url" => nil,
      "type" => "original",
      "note" => "Skills created directly in this library."
    }
  end

  if source == "https://github.com/menkesu/awesome-pm-skills and skills CLI installs"
    source = "https://github.com/menkesu/awesome-pm-skills"
    note = "Imported from the repository and related skills CLI install output."
  end

  if source == "OpenAI Codex bundled system skills"
    return {
      "slug" => "openai-codex-bundled-system-skills",
      "label" => "OpenAI Codex bundled system skills",
      "repository" => source,
      "url" => nil,
      "type" => "runtime",
      "note" => "Bundled with the local Codex runtime rather than imported from a public repo."
    }
  end

  begin
    uri = URI.parse(source)
    if uri.host == "github.com"
      parts = uri.path.sub(%r{\A/}, "").sub(/\.git\z/, "").split("/")
      owner, repo = parts[0], parts[1]
      if owner && repo
        return {
          "slug" => "#{owner}-#{repo}".downcase.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-+\z/, ""),
          "label" => "#{owner}/#{repo}",
          "repository" => "https://github.com/#{owner}/#{repo}",
          "url" => "https://github.com/#{owner}/#{repo}",
          "type" => "github",
          "note" => note
        }
      end
    end
  rescue URI::InvalidURIError
    # Fall through to generic source handling.
  end

  label = source.empty? ? fallback_slug.to_s : source
  {
    "slug" => (fallback_slug || label.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-+\z/, "")),
    "label" => label,
    "repository" => label,
    "url" => label.start_with?("http") ? label : nil,
    "type" => "other",
    "note" => note
  }
end

def markdown_escape(value)
  value.to_s.gsub("\n", " ").gsub("|", "\\|").strip
end

def tsv_escape(value)
  value.to_s.gsub("\t", " ").gsub("\r", " ").gsub("\n", " ").strip
end

def load_existing_manifest
  return {} unless File.exist?(MANIFEST_PATH)

  JSON.parse(File.read(MANIFEST_PATH))
end

def load_existing_categories(manifest)
  manifest.fetch("skills", []).to_h { |entry| [entry["name"], entry["category"]] }
end

def load_safety_policy
  return { "skills" => [] } unless File.exist?(SAFETY_POLICY_PATH)

  JSON.parse(File.read(SAFETY_POLICY_PATH))
end

def risk_flags_for(name, description, text)
  haystack = [name, description, text].join("\n").downcase
  flags = []
  flags << "security-sensitive" if haystack.match?(/attack|exploit|pentest|penetration|red[ -]?team|malware|vulnerab|credential|secrets?|owasp|sast|incident response/)
  flags << "network-access" if haystack.match?(/\b(curl|wget|invoke-webrequest|invoke-restmethod|fetch\(|scp|ftp|netcat|nc\s+-|socat)\b/)
  flags << "shell-execution" if haystack.match?(/\b(bash|zsh|sh|powershell|cmd\.exe|python|ruby|node|chmod\s+\+x)\b/)
  flags << "destructive-system-ops" if haystack.match?(/rm\s+-rf|chmod\s+777|chown\s+|sudo\s+|kill\s+-9|pkill|systemctl\s+(stop|disable)|launchctl\s+unload|reg\s+delete/)
  flags << "secrets-sensitive" if haystack.match?(/\.env|\.ssh|api[_ -]?key|token|secret|cookies\.sqlite|keychain|credentials/)
  flags.uniq
end

def trust_for(source, risk_flags)
  case source["type"]
  when "original"
    {
      "trust_level" => "curated",
      "review_status" => "maintained",
      "trust_summary" => "Created and maintained directly in this library."
    }
  when "runtime"
    {
      "trust_level" => "runtime",
      "review_status" => "runtime-bundled",
      "trust_summary" => "Bundled with the local runtime and tracked here for portability."
    }
  else
    {
      "trust_level" => risk_flags.empty? ? "imported" : "imported-review-recommended",
      "review_status" => "frontmatter-validated",
      "trust_summary" => "Imported from an upstream source; schema/frontmatter validated in this repo. Review source content before sensitive use."
    }
  end
end

def load_starter_packs(entries)
  return [] unless File.exist?(STARTER_PACKS_PATH)

  data = JSON.parse(File.read(STARTER_PACKS_PATH))
  names = entries.map { |entry| entry["name"] }.to_set
  packs = data.fetch("packs", [])
  duplicate_names = packs.map { |pack| pack["name"] }.group_by(&:itself).select { |_name, values| values.length > 1 }
  abort "Duplicate starter pack names: #{duplicate_names.keys.join(", ")}" unless duplicate_names.empty?

  packs.each do |pack|
    missing = pack.fetch("skills", []) - names.to_a
    next if missing.empty?

    abort "Starter pack #{pack["name"]} references missing skills: #{missing.join(", ")}"
  end

  packs.sort_by { |pack| pack["name"] }
end

def skill_entries(categories)
  paths = Dir.glob(File.join(SOURCES_DIR, "*", "skills", "*", "SKILL.md")).sort
  abort "No source skills found under sources/*/skills/*/SKILL.md" if paths.empty?

  entries = paths.map do |path|
    skill_dir = File.dirname(path)
    source_dir = File.expand_path("../..", skill_dir)
    source_slug = File.basename(source_dir)
    skill_name = File.basename(skill_dir)
    frontmatter = read_frontmatter(path)
    skill_text = File.read(path)
    metadata = frontmatter.fetch("metadata", {}) || {}
    source = normalize_source(metadata["source_repository"], fallback_slug: source_slug)
    source["slug"] = source_slug if source["slug"].nil? || source["slug"].empty?
    description = frontmatter["description"].to_s.strip
    category = categories[skill_name] || frontmatter["category"].to_s.strip
    category = "Uncategorized" if category.empty?
    license = frontmatter["license"].to_s.strip
    license = "Unspecified" if license.empty?
    risk_flags = risk_flags_for(skill_name, description, skill_text)
    trust = trust_for(source, risk_flags)

    {
      "name" => skill_name,
      "frontmatter_name" => frontmatter["name"],
      "description" => description,
      "category" => category,
      "license" => license,
      "canonical_path" => "sources/#{source_slug}/skills/#{skill_name}/",
      "export_path" => "dist/skills/#{skill_name}/",
      "imported_source_path" => metadata["source_path"],
      "source" => source,
      "risk_flags" => risk_flags,
      "trust" => trust,
      "filesystem_path" => skill_dir
    }
  end

  grouped_names = entries.group_by { |entry| entry["name"] }.select { |_name, values| values.length > 1 }
  unless grouped_names.empty?
    warn "Duplicate skill names found across source folders:"
    grouped_names.each do |name, values|
      warn "- #{name}: #{values.map { |value| value["canonical_path"] }.join(", ")}"
    end
    abort "Skill names must be unique before generating the flat export."
  end

  entries
end

def safe_reset_generated_dir(path, marker)
  if File.exist?(path)
    marker_path = File.join(path, marker)
    abort "Refusing to overwrite non-generated #{path}" unless File.exist?(marker_path)
    FileUtils.rm_rf(path)
  end
  FileUtils.mkdir_p(path)
  File.write(File.join(path, marker), "Generated by scripts/sync-skill-library.rb\n")
end

manifest = load_existing_manifest
safety_policy = load_safety_policy
quarantined_skills = safety_policy.fetch("skills", [])
generated_at = GeneratedOutput.date(manifest)
categories = load_existing_categories(manifest)
entries = skill_entries(categories)
grouped = entries.group_by { |entry| entry["source"]["slug"] }
starter_packs = load_starter_packs(entries)
bundle_memberships = Hash.new { |hash, key| hash[key] = [] }
starter_packs.each do |pack|
  pack.fetch("skills", []).each { |skill_name| bundle_memberships[skill_name] << pack["name"] }
end
source_rows = grouped.map do |slug, skills|
  source = skills.first["source"]
  licenses = skills.map { |skill| skill["license"] }.uniq.sort
  license_label = licenses.length == 1 ? licenses.first : licenses.join(", ")
  source.merge("slug" => slug, "count" => skills.length, "license" => license_label)
end.sort_by { |entry| [-entry["count"], entry["slug"]] }

safe_reset_generated_dir(EXPORT_DIR, GENERATED_EXPORT_MARKER)
entries.sort_by { |entry| entry["name"] }.each do |entry|
  FileUtils.cp_r(entry["filesystem_path"], File.join(EXPORT_DIR, entry["name"]))
end

safe_reset_generated_dir(BUNDLES_DIR, GENERATED_BUNDLES_MARKER)
starter_packs.each do |pack|
  File.write(File.join(BUNDLES_DIR, "#{pack["name"]}.txt"), pack.fetch("skills", []).join("\n") + "\n")
end

File.write(DIST_README, <<~MARKDOWN)
  # Flat Skills Export

  This directory is generated from `../sources/<source>/skills/`.
  It contains only the safe default install set. Skills removed by the safety
  policy are preserved under `../quarantine/` and documented in
  `../docs/SKILLS-SAFETY.md`.

  Agent Skills-compatible tools generally expect a flat layout:

  ```text
  <skills-root>/<skill-name>/SKILL.md
  ```

  Do not edit `dist/skills/` directly. Edit the canonical source skill under `sources/`, then run:

  ```bash
  ruby scripts/sync-skill-library.rb
  ```

  Search and discovery artifacts are generated beside this directory:

  - `skills-index.json` - machine-readable search index
  - `skills-index.tsv` - shell-friendly search index
  - `quarantine-index.json` and `quarantine-index.tsv` - blocked/gated skill index
  - `bundles.json` and `bundles/*.txt` - starter-pack definitions for installers
MARKDOWN

source_index = []
source_index << "# Skills by Source"
source_index << ""
source_index << "This directory is the organized source of truth for the skill library."
source_index << ""
source_index << "Canonical skill folders live under `sources/<source-folder>/skills/<skill-name>/`. The generated flat compatibility export lives in `../dist/skills/` for installers and agent tools that expect a flat Agent Skills layout."
source_index << ""
source_index << "| Source folder | Source | Type | License (SPDX) | Skills |"
source_index << "|---|---|---|---|---:|"

source_rows.each do |source|
  folder = source["slug"]
  label = source["url"] ? "[#{markdown_escape(source["label"])}](#{source["url"]})" : markdown_escape(source["label"])
  source_index << "| [`#{folder}`](#{folder}/) | #{label} | #{source["type"]} | #{markdown_escape(source["license"])} | #{source["count"]} |"

  source_dir = File.join(SOURCES_DIR, folder)
  FileUtils.mkdir_p(source_dir)
  skills_dir = File.join(source_dir, "skills")
  FileUtils.mkdir_p(skills_dir)

  skills = grouped.fetch(folder).sort_by { |skill| skill["name"] }
  lines = []
  lines << "# #{source["label"]}"
  lines << ""
  lines << "- Source folder: `sources/#{folder}/`"
  lines << "- Canonical skills: `sources/#{folder}/skills/`"
  lines << "- Source type: `#{source["type"]}`"
  lines << "- Skill count: #{skills.length}"
  lines << "- Repository: #{source["url"] ? "[#{source["repository"]}](#{source["url"]})" : source["repository"]}"
  lines << "- Note: #{source["note"]}" if source["note"] && !source["note"].empty?
  lines << ""
  lines << "Flat install/export copies are generated under `../../dist/skills/`."
  lines << ""
  lines << "## Skills"
  lines << ""
  lines << "| Skill | Category | Description | Original import path |"
  lines << "|---|---|---|---|"
  skills.each do |skill|
    source_path = skill["imported_source_path"] ? "`#{markdown_escape(skill["imported_source_path"])}`" : ""
    lines << "| [`#{skill["name"]}`](skills/#{skill["name"]}/) | #{markdown_escape(skill["category"])} | #{markdown_escape(skill["description"])} | #{source_path} |"
  end

  File.write(File.join(source_dir, "README.md"), lines.join("\n") + "\n")
end

File.write(File.join(SOURCES_DIR, GENERATED_SOURCE_MARKER), "Generated by scripts/sync-skill-library.rb\n")
File.write(File.join(SOURCES_DIR, "README.md"), source_index.join("\n") + "\n")

manifest["generated_at"] = generated_at
manifest["total_skills"] = entries.length
manifest["default_install_policy"] = "safe-default"
manifest["quarantined_skills"] = quarantined_skills.length
manifest["source_groups"] = source_rows
manifest["starter_packs"] = starter_packs.map do |pack|
  pack.merge(
    "count" => pack.fetch("skills", []).length
  )
end
manifest["skills"] = entries.sort_by { |entry| entry["name"] }.map do |entry|
  source = entry["source"]
  trust = entry["trust"]
  {
    "name" => entry["name"],
    "description" => entry["description"],
    "category" => entry["category"],
    "path" => entry["export_path"],
    "canonical_path" => entry["canonical_path"],
    "source_repository" => source["repository"],
    "source_slug" => source["slug"],
    "source_label" => source["label"],
    "source_type" => source["type"],
    "source_path" => entry["imported_source_path"],
    "source_note" => source["note"],
    "trust_level" => trust["trust_level"],
    "review_status" => trust["review_status"],
    "trust_summary" => trust["trust_summary"],
    "risk_flags" => entry["risk_flags"],
    "bundles" => bundle_memberships[entry["name"]].sort
  }.compact
end
File.write(MANIFEST_PATH, GeneratedOutput.json(manifest) + "\n")

category_rows = entries.group_by { |entry| entry["category"] }.map do |category, skills|
  { "name" => category, "count" => skills.length }
end.sort_by { |row| [-row["count"], row["name"]] }

trust_rows = entries.group_by { |entry| entry["trust"]["trust_level"] }.map do |trust_level, skills|
  { "name" => trust_level, "count" => skills.length }
end.sort_by { |row| [-row["count"], row["name"]] }

risk_rows = entries.flat_map { |entry| entry["risk_flags"] }.group_by(&:itself).map do |flag, values|
  { "name" => flag, "count" => values.length }
end.sort_by { |row| [-row["count"], row["name"]] }

index = {
  "generated_at" => generated_at,
  "total_skills" => entries.length,
  "default_install_policy" => "safe-default",
  "quarantined_skills" => quarantined_skills.length,
  "categories" => category_rows,
  "sources" => source_rows,
  "trust_levels" => trust_rows,
  "risk_flags" => risk_rows,
  "starter_packs" => starter_packs.map { |pack| pack.merge("count" => pack.fetch("skills", []).length) },
  "skills" => entries.sort_by { |entry| entry["name"] }.map do |entry|
    source = entry["source"]
    trust = entry["trust"]
    {
      "name" => entry["name"],
      "description" => entry["description"],
      "category" => entry["category"],
      "path" => entry["export_path"],
      "canonical_path" => entry["canonical_path"],
      "source_slug" => source["slug"],
      "source_label" => source["label"],
      "source_repository" => source["repository"],
      "source_type" => source["type"],
      "trust_level" => trust["trust_level"],
      "review_status" => trust["review_status"],
      "risk_flags" => entry["risk_flags"],
      "bundles" => bundle_memberships[entry["name"]].sort
    }
  end
}
File.write(INDEX_JSON_PATH, GeneratedOutput.json(index) + "\n")

tsv = []
tsv << %w[name category source_slug source_label trust_level review_status risk_flags bundles description].join("\t")
entries.sort_by { |entry| entry["name"] }.each do |entry|
  source = entry["source"]
  trust = entry["trust"]
  tsv << [
    entry["name"],
    entry["category"],
    source["slug"],
    source["label"],
    trust["trust_level"],
    trust["review_status"],
    entry["risk_flags"].join(","),
    bundle_memberships[entry["name"]].sort.join(","),
    entry["description"]
  ].map { |value| tsv_escape(value) }.join("\t")
end
File.write(INDEX_TSV_PATH, tsv.join("\n") + "\n")

quarantine_status_rows = quarantined_skills.group_by { |entry| entry["status"] }.map do |status, values|
  { "name" => status, "count" => values.length }
end.sort_by { |row| [row["name"]] }

quarantine_index = {
  "generated_at" => generated_at,
  "total_quarantined" => quarantined_skills.length,
  "statuses" => quarantine_status_rows,
  "skills" => quarantined_skills.sort_by { |entry| entry["name"] }
}
File.write(QUARANTINE_JSON_PATH, GeneratedOutput.json(quarantine_index) + "\n")

quarantine_tsv = []
quarantine_tsv << %w[name status source_slug original_path quarantine_path reason].join("\t")
quarantined_skills.sort_by { |entry| entry["name"] }.each do |entry|
  quarantine_tsv << [
    entry["name"],
    entry["status"],
    entry["source_slug"],
    entry["original_path"],
    entry["quarantine_path"],
    entry["reason"]
  ].map { |value| tsv_escape(value) }.join("\t")
end
File.write(QUARANTINE_TSV_PATH, quarantine_tsv.join("\n") + "\n")

File.write(BUNDLES_JSON_PATH, GeneratedOutput.json({
  "generated_at" => generated_at,
  "packs" => starter_packs.map { |pack| pack.merge("count" => pack.fetch("skills", []).length) }
}) + "\n")

doc = []
doc << "# Skill Sources"
doc << ""
doc << "Generated source map for every skill in the repository."
doc << ""
doc << "Canonical source skills live in `sources/<source-folder>/skills/<skill-name>/`. Generated flat install/export copies live in [`../dist/skills/`](../dist/skills/)."
doc << ""
doc << "## Source Groups"
doc << ""
doc << "| Source folder | Source | Type | License (SPDX) | Skills |"
doc << "|---|---|---|---|---:|"
source_rows.each do |source|
  label = source["url"] ? "[#{markdown_escape(source["label"])}](#{source["url"]})" : markdown_escape(source["label"])
  doc << "| [`#{source["slug"]}`](../sources/#{source["slug"]}/) | #{label} | #{source["type"]} | #{markdown_escape(source["license"])} | #{source["count"]} |"
end

duplicates = manifest.fetch("duplicate_source_names", {})
unless duplicates.empty?
  doc << ""
  doc << "## Duplicate Source Names Resolved"
  doc << ""
  doc << "When the same skill name appeared in multiple local source roots, the canonical source copy was kept and the other copies are listed below."
  doc << ""
  duplicates.sort.each do |name, copies|
    details = copies.map { |copy| "#{copy["source"]}:`#{copy["path"]}`" }.join(", ")
    doc << "- `#{name}`: #{details}"
  end
end

doc << ""
doc << "## Machine-Readable Manifest"
doc << ""
doc << "See [`../manifests/skills-manifest.json`](../manifests/skills-manifest.json). Each skill entry includes `canonical_path`, `path` for the flat export, `source_slug`, `source_label`, `source_type`, and `source_path` when available."
File.write(SOURCE_DOC_PATH, doc.join("\n") + "\n")

trust_doc = []
trust_doc << "# Skill Trust and Provenance"
trust_doc << ""
trust_doc << "Generated trust overview for the installable skill library."
trust_doc << ""
trust_doc << "The trust layer is intentionally conservative: imported skills can be useful while still needing human review before sensitive use."
trust_doc << ""
trust_doc << "## Trust Levels"
trust_doc << ""
trust_doc << "| Trust level | Count | Meaning |"
trust_doc << "|---|---:|---|"
trust_meanings = {
  "curated" => "Created and maintained directly in this library.",
  "runtime" => "Bundled with a local runtime and tracked here for portability.",
  "imported" => "Imported from an upstream source and schema/frontmatter validated here.",
  "imported-review-recommended" => "Imported and contains content that matched risk-sensitive keywords; review before sensitive use."
}
trust_rows.each do |row|
  trust_doc << "| `#{row["name"]}` | #{row["count"]} | #{trust_meanings.fetch(row["name"], "")} |"
end
unless risk_rows.empty?
  trust_doc << ""
  trust_doc << "## Risk Flags"
  trust_doc << ""
  trust_doc << "| Risk flag | Count |"
  trust_doc << "|---|---:|"
  risk_rows.each { |row| trust_doc << "| `#{row["name"]}` | #{row["count"]} |" }
end
trust_doc << ""
trust_doc << "## Source Groups"
trust_doc << ""
trust_doc << "| Source | Type | Trust posture | Skills |"
trust_doc << "|---|---|---|---:|"
source_rows.each do |source|
  posture = case source["type"]
            when "original" then "Curated in this repo"
            when "runtime" then "Runtime-provided"
            else "Imported upstream; validate before sensitive use"
            end
  label = source["url"] ? "[#{markdown_escape(source["label"])}](#{source["url"]})" : markdown_escape(source["label"])
  trust_doc << "| #{label} | `#{source["type"]}` | #{posture} | #{source["count"]} |"
end
trust_doc << ""
trust_doc << "## Safety Quarantine"
trust_doc << ""
trust_doc << "#{quarantined_skills.length} skill(s) are preserved under `../quarantine/` but removed from the default install/export path. See [`SKILLS-SAFETY.md`](SKILLS-SAFETY.md) for the policy, reasons, and reinstatement rules."
trust_doc << ""
trust_doc << "Machine-readable trust fields are included in [`../dist/skills-index.json`](../dist/skills-index.json) and [`../manifests/skills-manifest.json`](../manifests/skills-manifest.json)."
File.write(TRUST_DOC_PATH, trust_doc.join("\n") + "\n")

packs_doc = []
packs_doc << "# Starter Packs"
packs_doc << ""
packs_doc << "Starter packs are curated subsets for people who want a useful install without loading the entire library."
packs_doc << ""
packs_doc << "Install a pack with:"
packs_doc << ""
packs_doc << "```bash"
packs_doc << "curl -fsSL https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.sh | bash -s -- --bundle codex-essentials"
packs_doc << "```"
packs_doc << ""
starter_packs.each do |pack|
  packs_doc << "## #{pack["display_name"]}"
  packs_doc << ""
  packs_doc << "- Bundle: `#{pack["name"]}`"
  packs_doc << "- Skills: #{pack.fetch("skills", []).length}"
  packs_doc << "- Best for: #{pack["recommended_for"]}"
  packs_doc << ""
  packs_doc << pack["description"]
  packs_doc << ""
  packs_doc << "| Skill | Category | Trust |"
  packs_doc << "|---|---|---|"
  pack.fetch("skills", []).each do |skill_name|
    entry = entries.find { |candidate| candidate["name"] == skill_name }
    packs_doc << "| [`#{skill_name}`](../dist/skills/#{skill_name}/) | #{markdown_escape(entry["category"])} | `#{entry["trust"]["trust_level"]}` |"
  end
  packs_doc << ""
end
packs_doc << "Machine-readable bundle files live in [`../dist/bundles/`](../dist/bundles/) and [`../dist/bundles.json`](../dist/bundles.json)."
File.write(STARTER_PACKS_DOC_PATH, packs_doc.join("\n") + "\n")

safety_counts = quarantined_skills.group_by { |entry| entry["status"] }.map do |status, values|
  { "name" => status, "count" => values.length }
end.sort_by { |row| [row["name"]] }

catalog_doc = []
catalog_doc << "# Skills Catalog"
catalog_doc << ""
catalog_doc << "Complete generated index of every default-installable skill currently shipped in this repository."
catalog_doc << ""
catalog_doc << "- Generated: #{generated_at}"
catalog_doc << "- Default-installable skills: #{entries.length}"
catalog_doc << "- Quarantined or gated skills removed from default export: #{quarantined_skills.length}"
catalog_doc << ""
catalog_doc << "For machine-readable discovery, use [`../dist/skills-index.json`](../dist/skills-index.json) or [`../dist/skills-index.tsv`](../dist/skills-index.tsv). For curated install subsets, see [`STARTER-PACKS.md`](STARTER-PACKS.md). For trust and provenance metadata, see [`SKILLS-TRUST.md`](SKILLS-TRUST.md). For removed or gated skills, see [`SKILLS-SAFETY.md`](SKILLS-SAFETY.md)."
catalog_doc << ""
catalog_doc << "## Source Repositories Used"
source_rows.each do |source|
  label = source["url"] ? "#{source["label"]} - #{source["url"]}" : source["label"]
  catalog_doc << "- **#{markdown_escape(source["slug"])}:** #{markdown_escape(label)}"
end
catalog_doc << ""
catalog_doc << "## High-Leverage Routing Set"
catalog_doc << ""
catalog_doc << "| Skill | What it does |"
catalog_doc << "|---|---|"
entries_by_name = entries.to_h { |entry| [entry["name"], entry] }
[
  "codex-skill-orchestrator",
  "codex-workflows",
  "codex-design-expert",
  "skill-router",
  "brainstorming",
  "concise-planning",
  "writing-plans",
  "systematic-debugging",
  "test-driven-development",
  "verification-before-completion",
  "context7-cli",
  "get-api-docs",
  "gh-fix-ci",
  "dogfood",
  "find-skills",
  "business-model-designer",
  "startup-validator",
  "setting-okrs-goals",
  "business-model-canvas",
  "strategy-frameworks",
  "okr-frameworks",
  "metrics-frameworks",
  "zero-to-launch",
  "ai-startup-building"
].each do |skill_name|
  entry = entries_by_name[skill_name]
  next unless entry

  catalog_doc << "| [`#{skill_name}`](../dist/skills/#{skill_name}/) | #{markdown_escape(entry["description"])} |"
end
catalog_doc << ""
catalog_doc << "## Category Summary"
catalog_doc << ""
catalog_doc << "| Category | Count |"
catalog_doc << "|---|---:|"
category_rows.each { |row| catalog_doc << "| #{markdown_escape(row["name"])} | #{row["count"]} |" }
entries.group_by { |entry| entry["category"] }.sort_by { |category, _skills| category }.each do |category, skills|
  catalog_doc << ""
  catalog_doc << "## #{category}"
  catalog_doc << ""
  catalog_doc << "| Skill | What it does | Trust |"
  catalog_doc << "|---|---|---|"
  skills.sort_by { |skill| skill["name"] }.each do |skill|
    catalog_doc << "| [`#{skill["name"]}`](../dist/skills/#{skill["name"]}/) | #{markdown_escape(skill["description"])} | `#{skill["trust"]["trust_level"]}` |"
  end
end
File.write(CATALOG_DOC_PATH, catalog_doc.join("\n") + "\n")

safety_doc = []
safety_doc << "# Skill Safety Policy"
safety_doc << ""
safety_doc << "This repository ships a safe default skill export. Skills that raised material safety, compliance, impersonation, or external-action concerns are preserved for review under `../quarantine/`, but they are not copied into `../dist/skills/` and are not installed by the one-line installer."
safety_doc << ""
safety_doc << "- Default-installable skills: #{entries.length}"
safety_doc << "- Quarantined or gated skills: #{quarantined_skills.length}"
safety_doc << "- Policy manifest: [`../manifests/skill-safety-policy.json`](../manifests/skill-safety-policy.json)"
safety_doc << "- Audit report: [`SKILL-RISK-AUDIT-2026-05-21.md`](SKILL-RISK-AUDIT-2026-05-21.md)"
local_audit_doc = "LOCAL-CODEX-SKILLS-SAFETY-#{generated_at}.md"
safety_doc << "- Local Codex audit report: [`#{local_audit_doc}`](#{local_audit_doc})" if File.exist?(File.join(File.dirname(SAFETY_DOC_PATH), local_audit_doc))
safety_doc << ""
safety_doc << "## Status Counts"
safety_doc << ""
safety_doc << "| Status | Count | Meaning |"
safety_doc << "|---|---:|---|"
status_meanings = safety_policy.fetch("statuses", {})
safety_counts.each do |row|
  safety_doc << "| `#{row["name"]}` | #{row["count"]} | #{markdown_escape(status_meanings.fetch(row["name"], ""))} |"
end
safety_doc << ""
safety_doc << "## Local Codex Runtime Cleanup"
safety_doc << ""
safety_doc << "The same policy can be applied to already-installed local Codex skills with:"
safety_doc << ""
safety_doc << "```bash"
safety_doc << "ruby scripts/audit-local-codex-skills.rb --apply --fail-on-policy-matches"
safety_doc << "```"
safety_doc << ""
safety_doc << "This moves policy-matched user-installed skills out of active discovery roots like `~/.codex/skills` and into `~/.codex/skill-quarantine/<timestamp>/`. It does not delete them, and it does not move system or plugin-managed runtime skills."
safety_doc << ""
safety_doc << "## Quarantined Skills"
safety_doc << ""
safety_doc << "| Skill | Status | Original source | Quarantine path | Reason |"
safety_doc << "|---|---|---|---|---|"
quarantined_skills.sort_by { |entry| [entry["status"], entry["name"]] }.each do |entry|
  safety_doc << "| `#{entry["name"]}` | `#{entry["status"]}` | `#{entry["original_path"]}` | [`#{entry["quarantine_path"]}`](../#{entry["quarantine_path"]}) | #{markdown_escape(entry["reason"])} |"
end
safety_doc << ""
safety_doc << "## Reinstatement Rules"
safety_doc << ""
safety_doc << "A quarantined skill can return to `sources/` only after a maintainer rewrites it to remove the flagged behavior, updates this policy manifest, runs the full validation suite, and verifies that the skill does not create offensive, high-stakes, impersonation, or external-side-effect risk in the default install path."
File.write(SAFETY_DOC_PATH, safety_doc.join("\n") + "\n")

puts "Synced #{entries.length} skill(s)."
puts "Generated #{source_rows.length} source group(s)."
puts "Generated #{starter_packs.length} starter pack(s)."
puts "Quarantined #{quarantined_skills.length} skill(s) outside the default export."
puts "Flat export: #{EXPORT_DIR}"
source_rows.each { |source| puts "#{source["count"]}\t#{source["slug"]}\t#{source["label"]}" }
