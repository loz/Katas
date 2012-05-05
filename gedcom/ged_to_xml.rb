#!/usr/bin/env ruby -I./lib

require 'ged'

file = $*[0]
lines = File.read(file).split /\r*\n/
t = GED::Tokenizer.new
lines.each do |line|
  parser = GED::LineParser.new(line)
  t.process parser.parsed
end

builder = GED::XMLBuilder.new(t.tree)
puts builder.to_xml
