#!/usr/bin/env ruby
# Validate that quarantined/gated skills stay out of the default install path.

require "json"
require "set"

ROOT = File.expand_path("..", __dir__)
POLICY_PATH = File.join(ROOT, "manifests", "skill-safety-policy.json")

abort "Missing safety policy: #{POLICY_PATH}" unless File.exist?(POLICY_PATH)

policy = JSON.parse(File.read(POLICY_PATH))
policy_skills = policy.fetch("skills").map { |entry| entry.fetch("name") }.to_set
failures = []

Dir.glob(File.join(ROOT, "sources", "*", "skills", "*", "SKILL.md")).each do |path|
  name = File.basename(File.dirname(path))
  failures << "Policy skill still present in sources/: #{name} (#{path})" if policy_skills.include?(name)
end

Dir.glob(File.join(ROOT, "dist", "skills", "*", "SKILL.md")).each do |path|
  name = File.basename(File.dirname(path))
  failures << "Policy skill still present in dist/skills/: #{name} (#{path})" if policy_skills.include?(name)
end

policy.fetch("skills").each do |entry|
  quarantine_path = File.join(ROOT, entry.fetch("quarantine_path"), "SKILL.md")
  failures << "Missing quarantined copy for #{entry.fetch("name")}: #{quarantine_path}" unless File.exist?(quarantine_path)
end

Dir.glob(File.join(ROOT, "dist", "bundles", "*.txt")).each do |bundle_path|
  File.readlines(bundle_path, chomp: true).each_with_index do |line, index|
    name = line.strip
    next if name.empty?
    next unless policy_skills.include?(name)

    failures << "Bundle references quarantined skill: #{File.basename(bundle_path)}:#{index + 1} #{name}"
  end
end

default_skill_dirs = Dir.glob(File.join(ROOT, "dist", "skills", "*")).select { |path| File.directory?(path) }
default_skill_dirs.each do |dir|
  next if File.exist?(File.join(dir, "SKILL.md"))

  failures << "Default export skill directory has no SKILL.md: #{dir}"
end

duplicate_skill_dirs = default_skill_dirs.select { |path| File.basename(path).match?(/ \d+\z/) }
duplicate_bundle_files = Dir.glob(File.join(ROOT, "dist", "bundles", "*.txt")).select do |path|
  File.basename(path, ".txt").match?(/ \d+\z/)
end
unless duplicate_skill_dirs.empty?
  failures << "Numeric duplicate export directories remain: #{duplicate_skill_dirs.length}"
end
unless duplicate_bundle_files.empty?
  failures << "Numeric duplicate bundle files remain: #{duplicate_bundle_files.length}"
end

if failures.any?
  warn "Safety policy validation failed:"
  failures.each { |failure| warn "- #{failure}" }
  exit 1
end

puts "Safety policy valid: #{policy_skills.length} quarantined/gated skill(s) are outside the default install path."
