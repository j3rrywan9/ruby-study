#!/usr/bin/env ruby

lines = File.readlines("text.txt")
text = lines.join

line_count = lines.size

total_characters = text.length
total_characters_excluding_spaces = text.gsub(/\s+/, '').length

word_count = text.split.length

paragraph_count = text.split(/\n\n/).length

sentence_count = text.split(/\.|\?|!/).length

puts "#{line_count} lines"
puts "#{total_characters} characters"
puts "#{total_characters_excluding_spaces} characters excluding spaces"
puts "#{word_count} words"
puts "#{paragraph_count} paragraphs"
puts "#{sentence_count} sentences"
