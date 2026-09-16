#!/usr/bin/env ruby
# Version-Timestamp: 2026-09-15 21:58:41 AST
require 'minitest/autorun'
require_relative '../lib/generated-output'

class GeneratedOutputTest < Minitest::Test
  def test_empty_containers_and_strings_round_trip
    value = { 'array' => [], 'object' => {}, 'nested' => [[], {}], 'text' => "[\n\n]" }
    output = GeneratedOutput.json(value)
    assert_equal value, JSON.parse(output)
    assert_includes output, '"array": []'
    assert_includes output, '"object": {}'
    refute_match(/\[\n\s*\]/, output)
  end

  def test_recorded_date_does_not_depend_on_clock
    assert_equal '2026-09-15', GeneratedOutput.date({ 'generated_at' => '2026-09-15' })
    assert_raises(ArgumentError) { GeneratedOutput.date({ 'generated_at' => 'bad' }) }
  end
end
