#! /usr/bin/env ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: clean.rb [options]'

  opts.on('-h', '--[no-]help', 'Run help') do |h|
    options[:help] = h
    puts 'Here\'s some information about how to use me!'
  end

  opts.on('-p', '--prefixes PREFIXES', 'Read in prefixes') do |prefix|
    options[:prefix] = prefix    
    prefix_words = File.open("./#{options[:prefix]}", 'r').to_a
    prefix_words.map! { |prefix| prefix.chomp }
    print prefix_words
  end
end.parse!
