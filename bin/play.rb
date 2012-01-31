#!/usr/bin/env ruby -wKU -rubygems

require 'welder'
require "benchmark"
require 'set'

def error_and_exit(msg)
  puts msg
  exit(1)
end

dictionary_file = ARGV.last
error_and_exit("Cannot load dictionary file") unless File.exist?(dictionary_file)

words = File.read(dictionary_file).split("\n").map {|w| w.strip}
dictionary = Welder::Dictionary.new(words)
game = Welder::Game.new(8, dictionary)
game.populate
game.detect_words