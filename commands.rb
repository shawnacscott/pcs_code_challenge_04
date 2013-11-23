#! /usr/bin/env ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: clean.rb [options]"

  opts.on("-h", "--[no-]help", "Run help") do |h|
    options[:help] = h
  end
end.parse!

