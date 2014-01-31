#! /usr/bin/env ruby

require 'optparse'
require 'csv'
require 'pry'

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: `<filename.rb> [options]`'

  opts.on('-h', '--help', 'List available options and flags') do |h|
    puts opts
  end

  opts.on('-p', '--prefixes PREFIXES',
          'Read in prefixes; must be followed by a file name') do |prefix|
    options[:prefix] = prefix
    prefix_words = File.open("./#{options[:prefix]}", 'r').to_a
    prefix_words.map! { |prefix| prefix.chomp }
    options[:prefix_words] = prefix_words
  end

  opts.on('-i', '--input INPUT',
          'Read in raw data; must be followed by a file name') do |input|
    options[:input] = input
    options[:raw_customers] = File.open("./#{options[:input]}", 'r')
  end

  opts.on('-o', '--output OUTPUT',
          'Write to output file; must be followed by a file name') do |output|
    options[:output] = output
  end

  opts.on('-s', '--suffixes SUFFIXES',
          'Read in suffixes; must be followed by a file name') do |suffix|
    options[:suffix] = suffix
    suffix_words = File.open("./#{options[:suffix]}", 'r').to_a
    suffix_words.map! { |suffix| suffix.chomp }
    options[:suffix_words] = suffix_words
  end
end.parse!

# Cleans and categorizes incoming data
class LineParser

  def initialize(options)
    @prefix_words = options[:prefix_words]
    @suffix_words = options[:suffix_words]
    @parsed = {}
  end

  def parse(line)
    split(line)
    name_build
    phone?(@phone_parts)
    @parsed
  end

  def split(line)
    split_line = (/\t/).match(line)
    serialize(split_line)
  end

  def serialize(split_line)
    parts_of_name = split_line.pre_match.to_s
    @name_parts = parts_of_name.split(' ')
    parts_of_phone_number = split_line.post_match.to_s
    @phone_parts = parts_of_phone_number.split(' ')
  end

  def name_build
    @parsed[:prefix] = prefix?(@name_parts.first, @prefix_words)
    @parsed[:suffix] = suffix?(@name_parts.last, @suffix_words)
    @parsed[:last] = @name_parts.pop
    rest_of_name?(@name_parts)
  end

  def prefix?(possible_prefix, prefix_words)
    if prefix_words.include?(possible_prefix)
      @name_parts.delete_at(0)
      prefix = possible_prefix
    else
      prefix = ''
    end
    prefix
  end

  def suffix?(possible_suffix, suffix_words)
    if suffix_words.include?(possible_suffix)
      @name_parts.pop
      suffix = possible_suffix
    else
      suffix = ''
    end
    suffix
  end

  def rest_of_name?(name_parts)
    @parsed[:middle] = (name_parts.length == 2 ? @name_parts.pop : '')
    @parsed[:first] = (name_parts.length >= 1 ? @name_parts.pop : '')
  end

  def phone?(phone_parts)
    phone_parts = phone_parts.each { |x| x.gsub!(/\D/, '.') }
    case phone_parts.first.length
    when 14
      @parsed[:phone] = phone_parts.first
    when 13
      @parsed[:phone] = '1' + phone_parts.first
    when 12
      @parsed[:phone] = '1.' + phone_parts.first
    end
    @parsed[:extension] = (phone_parts.length == 2 ? phone_parts.pop.sub!(/^./, '') : '' )
  end

end

CSV.open("./#{options[:output]}", 'wb') do |csv|
  csv << %w[prefix first_name middle last_name suffix phone_number
            phone_extension]
  while line = options[:raw_customers].gets
    line_parser = LineParser.new(options)
    parsed_hash = line_parser.parse(line)

    csv << %W[#{parsed_hash[:prefix]}
              #{parsed_hash[:first]}
              #{parsed_hash[:middle]}
              #{parsed_hash[:last]}
              #{parsed_hash[:suffix]}
              #{parsed_hash[:phone]}
              #{parsed_hash[:extension]}]
  end
end
