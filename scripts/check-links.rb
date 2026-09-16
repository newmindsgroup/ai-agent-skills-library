#!/usr/bin/env ruby
# Check local Markdown links without crawling the large exported skill bodies.

# Read files as UTF-8 regardless of the shell locale (avoids "invalid byte
# sequence in US-ASCII" when LANG/LC_ALL are unset).
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

ROOT = File.expand_path("..", __dir__)

GLOBS = [
  "README.md",
  "CONTRIBUTING.md",
  "CHANGELOG.md",
  "docs/**/*.md",
  "agents/**/*.md",
  "runbooks/**/*.md",
  "prompts/**/*.md",
  "installers/**/*.md",
  "sources/README.md",
  "sources/*/README.md",
  "dist/README.md"
].freeze

SKIP_TARGETS = %w[url].freeze

files = GLOBS.flat_map { |pattern| Dir.glob(File.join(ROOT, pattern)) }.uniq.sort
missing = []

files.each do |file|
  text = File.read(file)
  text.scan(/!?\[[^\]]*\]\(([^)]+)\)/).flatten.each do |raw_href|
    href = raw_href.strip
    next if href.empty?
    next if SKIP_TARGETS.include?(href)
    next if href.start_with?("#")
    next if href.match?(/\A[a-z][a-z0-9+.-]*:/i)

    target_path = href.sub(/#.*/, "")
    next if target_path.empty?

    target_path = target_path[1..-2] if target_path.start_with?("<") && target_path.end_with?(">")
    target_path = target_path.gsub("%20", " ")
    absolute_target = File.expand_path(target_path, File.dirname(file))
    next if File.exist?(absolute_target)

    missing << [
      file.sub("#{ROOT}/", ""),
      href
    ]
  end
end

if missing.empty?
  puts "All local Markdown links resolve."
  exit 0
end

warn "Missing local Markdown links:"
missing.each { |file, href| warn "- #{file}: #{href}" }
exit 1
