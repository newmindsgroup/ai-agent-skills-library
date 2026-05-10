#!/usr/bin/env ruby
# Compact long source SKILL.md files by moving their original body into
# references/full-guidance.md and replacing SKILL.md with a short
# progressive-disclosure entrypoint.

require "fileutils"

log_path = ARGV[0] || "/tmp/ai-agent-skills-validate.log"
min_lines = Integer(ARGV[1] || 501)
max_lines = Integer(ARGV[2] || 10_000)

def find_skill_dir(name)
  matches = Dir.glob(File.join("sources", "*", "skills", name)).select { |path| File.directory?(path) }
  return matches.first if matches.length == 1

  legacy = File.join("skills", name)
  return legacy if matches.empty? && File.directory?(legacy)

  raise "expected exactly one source skill directory for #{name}, found #{matches.length}"
end

def titleize(name)
  name.split("-").map { |part| part.empty? ? part : part[0].upcase + part[1..] }.join(" ")
end

def split_skill(text)
  raise "missing frontmatter" unless text.start_with?("---\n")

  parts = text.split(/^---\s*\n/, 3)
  [parts[1], parts[2].sub(/\A\n/, "")]
end

def extract_description(frontmatter)
  line = frontmatter.lines.find { |entry| entry.start_with?("description:") }
  return nil unless line

  value = line.sub(/^description:\s*/, "").strip
  value = value[1..-2] if (value.start_with?("'") && value.end_with?("'")) ||
                           (value.start_with?('"') && value.end_with?('"'))
  value.gsub("''", "'")
end

def first_h1(body, fallback)
  body.each_line do |line|
    return line.sub(/^#\s+/, "").strip if line.start_with?("# ")
  end
  titleize(fallback)
end

def first_paragraphs(body, max_chars: 700)
  after_title = false
  paragraphs = []
  current = []

  body.each_line do |line|
    unless after_title
      after_title = true if line.start_with?("# ")
      next
    end

    break if line.start_with?("## ")

    stripped = line.strip
    if stripped.empty?
      unless current.empty?
        paragraphs << current.join(" ")
        current = []
      end
      next
    end

    next if stripped.start_with?("---") || stripped.start_with?("```") || stripped.start_with?("!")

    current << stripped
  end

  paragraphs << current.join(" ") unless current.empty?
  text = paragraphs.join("\n\n").strip
  text = text[0, max_chars].sub(/\s+\S*\z/, "...") if text.length > max_chars
  text
end

def extract_section_lines(body, heading, max_lines: 12)
  lines = body.lines
  start = lines.index { |line| line.strip.downcase == heading.downcase }
  return [] unless start

  collected = []
  lines[(start + 1)..].to_a.each do |line|
    break if line.start_with?("## ")

    stripped = line.rstrip
    next if stripped.empty? && collected.empty?

    collected << stripped
    break if collected.count { |item| !item.strip.empty? } >= max_lines
  end
  collected.reject { |line| line.strip.empty? }.first(max_lines)
end

def topic_map(body, limit: 18)
  topics = []
  body.each_line do |line|
    next unless line =~ /^(##|###)\s+(.+)/

    text = Regexp.last_match(2).strip
    next if text.empty?
    next if ["When to Use", "When NOT to Use", "When Not to Use", "Limitations", "Collaboration"]
            .any? { |skip| text.casecmp?(skip) }

    text = text.sub(/^\d+\.\s*/, "")
    topics << text unless topics.include?(text)
    break if topics.length >= limit
  end
  topics
end

def normalize_bullets(lines, fallback)
  meaningful = lines.map(&:strip).reject(&:empty?)
  meaningful = fallback if meaningful.empty?
  meaningful.map do |line|
    line = line.sub(/^[-*]\s*/, "")
    line = line.sub(/^\d+[.)]\s*/, "")
    "- #{line}"
  end
end

def next_reference_path(reference_dir)
  basename = "full-guidance.md"
  path = File.join(reference_dir, basename)
  return [path, basename] unless File.exist?(path)

  index = 2
  loop do
    basename = "full-guidance-#{index}.md"
    path = File.join(reference_dir, basename)
    return [path, basename] unless File.exist?(path)

    index += 1
  end
end

skills = []
File.readlines(log_path).each do |line|
  next unless line =~ /^\[warn\] (.+?) — SKILL\.md is\s+(\d+) lines/

  name = Regexp.last_match(1)
  count = Integer(Regexp.last_match(2))
  skills << [count, name] if count >= min_lines && count <= max_lines
end

skills.sort_by! { |count, _name| -count }

skills.each do |_count, name|
  dir = find_skill_dir(name)
  skill_path = File.join(dir, "SKILL.md")
  frontmatter, body = split_skill(File.read(skill_path))
  title = first_h1(body, name)
  description = extract_description(frontmatter) || titleize(name)
  overview = first_paragraphs(body)
  overview = description if overview.empty?

  topics = topic_map(body)
  topics = ["Complete usage guidance", "Examples", "Validation checks", "Limitations"] if topics.empty?

  reference_dir = File.join(dir, "references")
  FileUtils.mkdir_p(reference_dir)
  reference_path, reference_basename = next_reference_path(reference_dir)
  File.write(reference_path, <<~MARKDOWN)
    # #{title} Full Guidance

    This reference preserves the complete long-form guidance that originally lived in `SKILL.md`.
    Load it only when the task needs implementation details, examples, anti-patterns, validation checks, or platform-specific edge cases.

    #{body}
  MARKDOWN

  when_lines = extract_section_lines(body, "## When to Use", max_lines: 10)
  when_bullets = normalize_bullets(when_lines, [
    "The request matches the skill description: #{description}",
    "The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.",
    "The work would benefit from the complete guidance preserved in `references/#{reference_basename}`."
  ])

  not_lines = extract_section_lines(body, "## When NOT to Use", max_lines: 8)
  not_lines = extract_section_lines(body, "## When Not to Use", max_lines: 8) if not_lines.empty?
  limitations = extract_section_lines(body, "## Limitations", max_lines: 8)

  output = []
  output << "---"
  output.concat(frontmatter.lines.map(&:rstrip))
  output << "---"
  output << ""
  output << "# #{title}"
  output << ""
  output << overview
  output << ""
  output << "## When to Use"
  output.concat(when_bullets)
  unless not_lines.empty?
    output << ""
    output << "## When Not to Use"
    output.concat(normalize_bullets(not_lines, []))
  end
  output << ""
  output << "## Core Workflow"
  output << "1. Confirm the request matches this skill's trigger, scope, and risk profile."
  output << "2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code."
  output << "3. Load `references/#{reference_basename}` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed."
  output << "4. Apply only the relevant guidance instead of loading or repeating the entire reference by default."
  output << "5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference."
  output << ""
  output << "## Topic Map"
  topics.each { |topic| output << "- #{topic}" }
  output << ""
  output << "## Reference Map"
  output << "- `references/#{reference_basename}` preserves the complete original guidance, including examples and detailed edge cases."
  unless limitations.empty?
    output << ""
    output << "## Limitations"
    output.concat(normalize_bullets(limitations, []))
  end
  output << ""
  output << "## Progressive Loading"
  output << "Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material."

  File.write(skill_path, output.join("\n") + "\n")
end

puts "Compacted #{skills.length} skill(s) from #{min_lines} to #{max_lines} lines."
skills.each { |count, name| puts "#{count}\t#{name}" }
