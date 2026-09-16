#!/usr/bin/env ruby
# Audit locally installed Codex-compatible skills against this repo's safety policy.
#
# Dry-run by default. Pass --apply to move matching active user-installed skills
# out of discoverable skill roots and into a local quarantine outside ~/.codex/skills.

require "date"
require "fileutils"
require "json"
require "optparse"
require "set"
require "time"

ROOT = File.expand_path("..", __dir__)
POLICY_PATH = File.join(ROOT, "manifests", "skill-safety-policy.json")
SAFE_INDEX_PATH = File.join(ROOT, "dist", "skills-index.json")
LOCAL_ALLOWLIST_PATH = File.join(ROOT, "manifests", "local-codex-skill-allowlist.json")

def expand(path)
  File.expand_path(path.gsub(/\A~/, Dir.home))
end

def existing(paths)
  paths.map { |path| expand(path) }.select { |path| Dir.exist?(path) }
end

def sanitize_label(path)
  path.sub(%r{\A#{Regexp.escape(Dir.home)}/?}, "")
      .gsub(%r{[^A-Za-z0-9._-]+}, "-")
      .gsub(/\A-+|-+\z/, "")
      .then { |value| value.empty? ? "root" : value }
end

def relative_to(path, root)
  path.sub(%r{\A#{Regexp.escape(root)}/?}, "")
end

def markdown_escape(value)
  value.to_s.gsub("\n", " ").gsub("|", "\\|").strip
end

def unique_destination(path)
  return path unless File.exist?(path)

  index = 2
  candidate = "#{path}-#{index}"
  while File.exist?(candidate)
    index += 1
    candidate = "#{path}-#{index}"
  end
  candidate
end

def prune_empty_parents(start_dir, stop_dir)
  current = File.expand_path(start_dir)
  stop = File.expand_path(stop_dir)
  while current.start_with?(stop) && current != stop
    break unless Dir.exist?(current)
    break unless (Dir.children(current) - [".DS_Store"]).empty?

    FileUtils.rm_rf(current)
    current = File.dirname(current)
  end
end

def default_roots
  active = existing([
    "~/.codex/skills",
    "~/.agents/skills"
  ]).map do |path|
    {
      "label" => sanitize_label(path),
      "path" => path,
      "mode" => "active-user",
      "apply" => true
    }
  end

  runtime = existing([
    "~/.codex/skills/.system",
    "~/.codex/plugins/cache/openai-bundled",
    "~/.codex/plugins/cache/openai-primary-runtime"
  ])
  runtime += Dir.glob(expand("~/.codex/plugins/cache/openai-curated/*/*/skills")).select { |path| Dir.exist?(path) }
  runtime = runtime.uniq.map do |path|
    {
      "label" => sanitize_label(path),
      "path" => path,
      "mode" => "runtime-or-plugin",
      "apply" => false
    }
  end

  active + runtime
end

def load_local_allowlist
  return {} unless File.exist?(LOCAL_ALLOWLIST_PATH)

  JSON.parse(File.read(LOCAL_ALLOWLIST_PATH)).fetch("skills", []).to_h { |entry| [entry.fetch("name"), entry] }
end

def scan_roots(roots, policy_by_name, safe_names, local_allow_by_name)
  records = []

  roots.each do |root|
    Dir.glob(File.join(root.fetch("path"), "**", "SKILL.md"), File::FNM_DOTMATCH).sort.each do |skill_md|
      relative_skill_md = relative_to(skill_md, root.fetch("path"))
      next if root.fetch("mode") == "active-user" && relative_skill_md.start_with?(".system/")

      skill_dir = File.dirname(skill_md)
      name = File.basename(skill_dir)
      policy = policy_by_name[name]
      local_allow = local_allow_by_name[name]
      in_safe_index = safe_names.include?(name)
      records << {
        "name" => name,
        "path" => skill_dir,
        "skill_md" => skill_md,
        "relative_path" => relative_to(skill_dir, root.fetch("path")),
        "root_label" => root.fetch("label"),
        "root_path" => root.fetch("path"),
        "root_mode" => root.fetch("mode"),
        "apply_root" => root.fetch("apply"),
        "policy_status" => policy && policy.fetch("status"),
        "policy_reason" => policy && policy.fetch("reason"),
        "local_allow_status" => local_allow && local_allow.fetch("status"),
        "local_allow_reason" => local_allow && local_allow.fetch("reason"),
        "in_safe_default_index" => in_safe_index,
        "unknown_to_library" => !in_safe_index && policy.nil? && local_allow.nil?
      }
    end
  end

  records
end

def move_policy_matches(records, quarantine_root)
  actions = []
  records.select { |record| record["apply_root"] && record["policy_status"] }.each do |record|
    destination = File.join(
      quarantine_root,
      record.fetch("policy_status"),
      record.fetch("root_label"),
      record.fetch("relative_path")
    )
    destination = unique_destination(destination)
    FileUtils.mkdir_p(File.dirname(destination))
    FileUtils.mv(record.fetch("path"), destination)
    prune_empty_parents(File.dirname(record.fetch("path")), record.fetch("root_path"))

    actions << {
      "name" => record.fetch("name"),
      "status" => record.fetch("policy_status"),
      "reason" => record.fetch("policy_reason"),
      "from" => record.fetch("path"),
      "to" => destination
    }
  end
  actions
end

def summarize(records)
  active = records.select { |record| record["root_mode"] == "active-user" }
  runtime = records.select { |record| record["root_mode"] == "runtime-or-plugin" }
  active_policy = active.select { |record| record["policy_status"] }
  unknown = active.select { |record| record["unknown_to_library"] }
  local_allowed = active.select { |record| record["local_allow_status"] }
  duplicates = active.group_by { |record| record["name"] }
                     .select { |_name, values| values.length > 1 }
                     .transform_values { |values| values.map { |record| record["path"] } }

  {
    "total_records" => records.length,
    "active_user_skills" => active.length,
    "runtime_or_plugin_skills" => runtime.length,
    "active_policy_matches" => active_policy.length,
    "active_unknown_to_library" => unknown.length,
    "active_local_allowlisted" => local_allowed.length,
    "active_duplicate_names" => duplicates.length,
    "policy_matches_by_status" => active_policy.group_by { |record| record["policy_status"] }
                                               .transform_values(&:length)
                                               .sort.to_h
  }
end

def duplicate_details(records)
  active = records.select { |record| record["root_mode"] == "active-user" }
  active.group_by { |record| record["name"] }
        .select { |_name, values| values.length > 1 }
        .sort
        .map do |name, values|
          skill_md_values = values.map { |record| record["skill_md"] }
          identical = skill_md_values.all? { |path| File.exist?(path) } &&
                      skill_md_values.map { |path| File.read(path) }.uniq.length == 1
          {
            "name" => name,
            "identical_skill_md" => identical,
            "paths" => values.map { |record| record["path"] }
          }
        end
end

options = {
  "apply" => false,
  "fail_on_policy_matches" => false,
  "quarantine_root" => File.join(Dir.home, ".codex", "skill-quarantine", Time.now.utc.strftime("%Y%m%dT%H%M%SZ")),
  "json_path" => File.join(ROOT, "manifests", "local-codex-skills-audit.json"),
  "markdown_path" => File.join(ROOT, "docs", "LOCAL-CODEX-SKILLS-SAFETY-#{Date.today.iso8601}.md"),
  "roots" => []
}

OptionParser.new do |parser|
  parser.banner = "Usage: ruby scripts/audit-local-codex-skills.rb [options]"
  parser.on("--apply", "Move policy-matched active user skills to local quarantine.") { options["apply"] = true }
  parser.on("--fail-on-policy-matches", "Exit non-zero if active policy matches remain after scan/apply.") { options["fail_on_policy_matches"] = true }
  parser.on("--quarantine-root PATH", "Local quarantine destination outside active skill roots.") { |path| options["quarantine_root"] = expand(path) }
  parser.on("--json PATH", "Write machine-readable audit JSON.") { |path| options["json_path"] = File.expand_path(path) }
  parser.on("--markdown PATH", "Write human-readable audit Markdown.") { |path| options["markdown_path"] = File.expand_path(path) }
  parser.on("--root PATH", "Add an active user skill root to scan/apply. May be repeated.") { |path| options["roots"] << expand(path) }
end.parse!

abort "Missing safety policy: #{POLICY_PATH}" unless File.exist?(POLICY_PATH)
abort "Missing safe skills index: #{SAFE_INDEX_PATH}" unless File.exist?(SAFE_INDEX_PATH)

policy = JSON.parse(File.read(POLICY_PATH))
policy_by_name = policy.fetch("skills").to_h { |entry| [entry.fetch("name"), entry] }
safe_index = JSON.parse(File.read(SAFE_INDEX_PATH))
safe_names = safe_index.fetch("skills").map { |entry| entry.fetch("name") }.to_set
local_allow_by_name = load_local_allowlist

roots = if options["roots"].empty?
          default_roots
        else
          options["roots"].select { |path| Dir.exist?(path) }.map do |path|
            { "label" => sanitize_label(path), "path" => path, "mode" => "active-user", "apply" => true }
          end
        end

abort "No local skill roots found to scan." if roots.empty?

before_records = scan_roots(roots, policy_by_name, safe_names, local_allow_by_name)
actions = options["apply"] ? move_policy_matches(before_records, options.fetch("quarantine_root")) : []
after_records = scan_roots(roots, policy_by_name, safe_names, local_allow_by_name)

before_summary = summarize(before_records)
after_summary = summarize(after_records)

audit = {
  "generated_at" => Time.now.utc.iso8601,
  "mode" => options["apply"] ? "apply" : "dry-run",
  "policy_path" => "manifests/skill-safety-policy.json",
  "safe_index_path" => "dist/skills-index.json",
  "local_allowlist_path" => File.exist?(LOCAL_ALLOWLIST_PATH) ? "manifests/local-codex-skill-allowlist.json" : nil,
  "quarantine_root" => options.fetch("quarantine_root"),
  "roots" => roots,
  "before" => before_summary,
  "after" => after_summary,
  "actions" => actions,
  "remaining_active_policy_matches" => after_records.select { |record| record["root_mode"] == "active-user" && record["policy_status"] },
  "active_local_allowlisted" => after_records.select { |record| record["root_mode"] == "active-user" && record["local_allow_status"] },
  "active_unknown_to_library" => after_records.select { |record| record["root_mode"] == "active-user" && record["unknown_to_library"] },
  "active_duplicate_details" => duplicate_details(after_records),
  "runtime_or_plugin_policy_matches" => after_records.select { |record| record["root_mode"] == "runtime-or-plugin" && record["policy_status"] }
}

FileUtils.mkdir_p(File.dirname(options.fetch("json_path")))
File.write(options.fetch("json_path"), JSON.pretty_generate(audit) + "\n")

lines = []
lines << "# Local Codex Skills Safety Audit"
lines << ""
lines << "Generated: #{audit["generated_at"]}"
lines << ""
lines << "This report applies the repository safety policy to locally installed Codex-compatible skill roots. Active user-installed policy matches are moved only when the script is run with `--apply`."
lines << ""
lines << "## Summary"
lines << ""
lines << "| Metric | Before | After |"
lines << "|---|---:|---:|"
[
  ["Active user skills", "active_user_skills"],
  ["Runtime/plugin skills scanned", "runtime_or_plugin_skills"],
  ["Active policy matches", "active_policy_matches"],
  ["Active unknown-to-library skills", "active_unknown_to_library"],
  ["Active local allowlisted skills", "active_local_allowlisted"],
  ["Active duplicate skill names", "active_duplicate_names"]
].each do |label, key|
  lines << "| #{label} | #{before_summary.fetch(key)} | #{after_summary.fetch(key)} |"
end
lines << ""
lines << "- Mode: `#{audit["mode"]}`"
lines << "- Local quarantine root: `#{audit["quarantine_root"]}`"
lines << "- Audit manifest: [`../manifests/local-codex-skills-audit.json`](../manifests/local-codex-skills-audit.json)"
lines << ""

unless actions.empty?
  lines << "## Local Moves"
  lines << ""
  lines << "| Skill | Status | From | To | Reason |"
  lines << "|---|---|---|---|---|"
  actions.sort_by { |action| [action["status"], action["name"]] }.each do |action|
    lines << "| `#{action["name"]}` | `#{action["status"]}` | `#{markdown_escape(action["from"])}` | `#{markdown_escape(action["to"])}` | #{markdown_escape(action["reason"])} |"
  end
  lines << ""
end

remaining = audit.fetch("remaining_active_policy_matches")
unless remaining.empty?
  lines << "## Remaining Active Policy Matches"
  lines << ""
  lines << "| Skill | Status | Path | Reason |"
  lines << "|---|---|---|---|"
  remaining.sort_by { |record| [record["policy_status"], record["name"], record["path"]] }.each do |record|
    lines << "| `#{record["name"]}` | `#{record["policy_status"]}` | `#{markdown_escape(record["path"])}` | #{markdown_escape(record["policy_reason"])} |"
  end
  lines << ""
end

local_allowed = audit.fetch("active_local_allowlisted")
unless local_allowed.empty?
  lines << "## Reviewed Local-Only Allowlist"
  lines << ""
  lines << "These active local skills are intentionally kept even though they are not part of the public safe-default library export."
  lines << ""
  lines << "| Skill | Status | Path | Reason |"
  lines << "|---|---|---|---|"
  local_allowed.sort_by { |record| [record["local_allow_status"], record["name"], record["path"]] }.each do |record|
    lines << "| `#{record["name"]}` | `#{record["local_allow_status"]}` | `#{markdown_escape(record["path"])}` | #{markdown_escape(record["local_allow_reason"])} |"
  end
  lines << ""
end

unknown = audit.fetch("active_unknown_to_library")
unless unknown.empty?
  lines << "## Active Skills Not In This Library Manifest"
  lines << ""
  lines << "These were not quarantined automatically because they are not named in the current safety policy. Review them separately before adding them to the public library or default export."
  lines << ""
  lines << "| Skill | Path |"
  lines << "|---|---|"
  unknown.sort_by { |record| [record["name"], record["path"]] }.each do |record|
    lines << "| `#{record["name"]}` | `#{markdown_escape(record["path"])}` |"
  end
  lines << ""
end

duplicates = audit.fetch("active_duplicate_details")
unless duplicates.empty?
  lines << "## Active Duplicate Names"
  lines << ""
  lines << "These duplicates are reported so routing/debugging stays explicit. Identical copies were left in place when they span shared roots such as `~/.codex/skills` and `~/.agents/skills`."
  lines << ""
  lines << "| Skill | Identical SKILL.md | Paths |"
  lines << "|---|---|---|"
  duplicates.each do |entry|
    lines << "| `#{entry["name"]}` | `#{entry["identical_skill_md"]}` | #{entry["paths"].map { |path| "`#{markdown_escape(path)}`" }.join("<br>")} |"
  end
  lines << ""
end

runtime_matches = audit.fetch("runtime_or_plugin_policy_matches")
unless runtime_matches.empty?
  lines << "## Runtime Or Plugin Policy Matches"
  lines << ""
  lines << "These are reported but not moved by this script because they live under system or plugin-managed roots."
  lines << ""
  lines << "| Skill | Status | Root | Path | Reason |"
  lines << "|---|---|---|---|---|"
  runtime_matches.sort_by { |record| [record["policy_status"], record["name"], record["path"]] }.each do |record|
    lines << "| `#{record["name"]}` | `#{record["policy_status"]}` | `#{record["root_label"]}` | `#{markdown_escape(record["path"])}` | #{markdown_escape(record["policy_reason"])} |"
  end
  lines << ""
end

lines << "## Operating Rule"
lines << ""
lines << "Quarantined local skills are preserved outside active discovery paths so Codex will not load them automatically. Delete only after you no longer need the evidence trail; keep the policy entry until the library intentionally reclassifies or rewrites that skill."

FileUtils.mkdir_p(File.dirname(options.fetch("markdown_path")))
File.write(options.fetch("markdown_path"), lines.join("\n") + "\n")

puts "Local Codex skills audit complete."
puts "Mode: #{audit["mode"]}"
puts "Active policy matches before: #{before_summary.fetch("active_policy_matches")}"
puts "Active policy matches after: #{after_summary.fetch("active_policy_matches")}"
puts "Moved to local quarantine: #{actions.length}"
puts "Unknown active local skills after: #{after_summary.fetch("active_unknown_to_library")}"
puts "Report: #{options.fetch("markdown_path")}"
puts "Manifest: #{options.fetch("json_path")}"

if options["fail_on_policy_matches"] && after_summary.fetch("active_policy_matches").positive?
  exit 1
end
