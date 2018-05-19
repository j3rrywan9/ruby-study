#!/usr/bin/env ruby

lines = File.readlines("text.txt")

line_count = lines.size
text = lines.join

total_characters = text.length
total_characters_excluding_spaces = text.gsub(/\s+/, '').length

word_count = text.split.length

puts "#{line_count} lines"
puts "#{total_characters} characters"
puts "#{total_characters_excluding_spaces} characters excluding spaces"
puts "#{word_count} words"
