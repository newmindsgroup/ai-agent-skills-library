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
require "uri"
require "yaml"

ROOT = File.expand_path("..", __dir__)
SOURCES_DIR = File.join(ROOT, "sources")
EXPORT_DIR = File.join(ROOT, "dist", "skills")
DIST_README = File.join(ROOT, "dist", "README.md")
MANIFEST_PATH = File.join(ROOT, "manifests", "skills-manifest.json")
SOURCE_DOC_PATH = File.join(ROOT, "docs", "SKILL-SOURCES.md")
GENERATED_SOURCE_MARKER = ".generated-source-index"
GENERATED_EXPORT_MARKER = ".generated-flat-skills"

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

def load_existing_manifest
  return {} unless File.exist?(MANIFEST_PATH)

  JSON.parse(File.read(MANIFEST_PATH))
end

def load_existing_categories(manifest)
  manifest.fetch("skills", []).to_h { |entry| [entry["name"], entry["category"]] }
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
    metadata = frontmatter.fetch("metadata", {}) || {}
    source = normalize_source(metadata["source_repository"], fallback_slug: source_slug)
    source["slug"] = source_slug if source["slug"].nil? || source["slug"].empty?

    {
      "name" => skill_name,
      "frontmatter_name" => frontmatter["name"],
      "description" => frontmatter["description"].to_s.strip,
      "category" => categories[skill_name] || "Uncategorized",
      "canonical_path" => "sources/#{source_slug}/skills/#{skill_name}/",
      "export_path" => "dist/skills/#{skill_name}/",
      "imported_source_path" => metadata["source_path"],
      "source" => source,
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
categories = load_existing_categories(manifest)
entries = skill_entries(categories)
grouped = entries.group_by { |entry| entry["source"]["slug"] }
source_rows = grouped.map do |slug, skills|
  source = skills.first["source"]
  source.merge("slug" => slug, "count" => skills.length)
end.sort_by { |entry| [-entry["count"], entry["slug"]] }

safe_reset_generated_dir(EXPORT_DIR, GENERATED_EXPORT_MARKER)
entries.sort_by { |entry| entry["name"] }.each do |entry|
  FileUtils.cp_r(entry["filesystem_path"], File.join(EXPORT_DIR, entry["name"]))
end

File.write(DIST_README, <<~MARKDOWN)
  # Flat Skills Export

  This directory is generated from `../sources/<source>/skills/`.

  Agent Skills-compatible tools generally expect a flat layout:

  ```text
  <skills-root>/<skill-name>/SKILL.md
  ```

  Do not edit `dist/skills/` directly. Edit the canonical source skill under `sources/`, then run:

  ```bash
  ruby scripts/sync-skill-library.rb
  ```
MARKDOWN

source_index = []
source_index << "# Skills by Source"
source_index << ""
source_index << "This directory is the organized source of truth for the skill library."
source_index << ""
source_index << "Canonical skill folders live under `sources/<source-folder>/skills/<skill-name>/`. The generated flat compatibility export lives in `../dist/skills/` for installers and agent tools that expect a flat Agent Skills layout."
source_index << ""
source_index << "| Source folder | Source | Type | Skills |"
source_index << "|---|---|---|---:|"

source_rows.each do |source|
  folder = source["slug"]
  label = source["url"] ? "[#{markdown_escape(source["label"])}](#{source["url"]})" : markdown_escape(source["label"])
  source_index << "| [`#{folder}`](#{folder}/) | #{label} | #{source["type"]} | #{source["count"]} |"

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

manifest["generated_at"] ||= Date.today.iso8601
manifest["total_skills"] = entries.length
manifest["source_groups"] = source_rows
manifest["skills"] = entries.sort_by { |entry| entry["name"] }.map do |entry|
  source = entry["source"]
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
    "source_note" => source["note"]
  }.compact
end
File.write(MANIFEST_PATH, JSON.pretty_generate(manifest) + "\n")

doc = []
doc << "# Skill Sources"
doc << ""
doc << "Generated source map for every skill in the repository."
doc << ""
doc << "Canonical source skills live in `sources/<source-folder>/skills/<skill-name>/`. Generated flat install/export copies live in [`../dist/skills/`](../dist/skills/)."
doc << ""
doc << "## Source Groups"
doc << ""
doc << "| Source folder | Source | Type | Skills |"
doc << "|---|---|---|---:|"
source_rows.each do |source|
  label = source["url"] ? "[#{markdown_escape(source["label"])}](#{source["url"]})" : markdown_escape(source["label"])
  doc << "| [`#{source["slug"]}`](../sources/#{source["slug"]}/) | #{label} | #{source["type"]} | #{source["count"]} |"
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

puts "Synced #{entries.length} skill(s)."
puts "Generated #{source_rows.length} source group(s)."
puts "Flat export: #{EXPORT_DIR}"
source_rows.each { |source| puts "#{source["count"]}\t#{source["slug"]}\t#{source["label"]}" }
