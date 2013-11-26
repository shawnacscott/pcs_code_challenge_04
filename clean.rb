#! /usr/bin/env ruby

require 'optparse'
require 'pry'

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
    options[:prefix_words] = prefix_words
  end

  opts.on('-i', '--input INPUT', 'Read in input') do |input|
    options[:input] = input
    options[:raw_customers] = File.open("./#{options[:input]}", 'r')
  end

  opts.on('-o', '--output OUTPUT', 'Write to output file') do |output|
    options[:output] = output
  end

  opts.on('-s', '--suffixes SUFFIXES', 'Read in suffixes') do |suffix|
    options[:suffix] = suffix
    suffix_words = File.open("./#{options[:suffix]}", 'r').to_a
    suffix_words.map! { |suffix| suffix.chomp }
    options[:suffix_words] = suffix_words
  end
end.parse!

class LineParser
  attr_accessor :parts_of_name
  attr_reader :prefix, :first_name, :middle_name, :last_name, 
              :suffix, :phone_number, :extension

  def initialize
    @prefix = ''
    @first_name = ''
    @middle_name = ''
    @last_name = ''
    @suffix = ''
    @phone_number = ''
    @extension = ''
  end

  def prefix?(parts_of_name, prefix_words)
    @possible_prefix = (/^\S*/).match(parts_of_name).to_s
    if prefix_words.include?(@possible_prefix)
      @prefix = @possible_prefix
      @parts_of_name = /^\S*(.*)/.match(parts_of_name)
      @parts_of_name = @parts_of_name[1].to_s.strip
    else
      @prefix = ''
      @parts_of_name = parts_of_name
    end
  end

  def suffix?(parts_of_name, suffix_words)
    @pre_suffix = (/\S*$/).match(parts_of_name)
    @possible_suffix = @pre_suffix.to_s
    if suffix_words.include?(@possible_suffix)
      @suffix = @possible_suffix
      @parts_of_name = /(.*)\S*$/.match(parts_of_name)
      @parts_of_name = @pre_suffix.pre_match.strip
    else
      @suffix = ''
      @parts_of_name = parts_of_name
    end
  end

  def rest_of_name?(parts_of_name)
    @parts_of_name = parts_of_name.split(' ')
    if @parts_of_name.length == 3
      @last_name = @parts_of_name.pop
      @middle_name = @parts_of_name.pop
      @first_name = @parts_of_name.pop
    elsif @parts_of_name.length == 2
      @last_name = @parts_of_name.pop
      @middle_name = ''
      @first_name = @parts_of_name.pop
    else
      @last_name = @parts_of_name.pop
      @middle_name = ''
      @first_name = ''
    end
    @last_name
    @middle_name
    @first_name
  end
end

print 'prefix,first_name,middle,last_name,suffix,phone_number,phone_extension'

while line = options[:raw_customers].gets
  line_parser = LineParser.new

  parts_of_record = (/(.*)\t/).match(line)
  parts_of_name = parts_of_record[1].to_s
  line_parser.prefix?(parts_of_name, options[:prefix_words])
  parts_of_name = line_parser.parts_of_name
  line_parser.suffix?(parts_of_name, options[:suffix_words])
  parts_of_name = line_parser.parts_of_name
  line_parser.rest_of_name?(parts_of_name)

  puts "#{line_parser.prefix},#{line_parser.first_name},#{line_parser.middle_name},#{line_parser.last_name},#{line_parser.suffix}"
end