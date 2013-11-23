# Old analyze file


# Analyze raw data to create prefix histogram
class PrefixHash
  attr_reader :prefix_hash

  def initialize
    @prefix_hash = Hash.new(0)
    @prefix = :symbol
  end

  def add_to_hash
    @prefix_hash[@prefix] += 1
  end

  def find_prefix(file_name)
    open(file_name).each_line do |line|
      @prefix = (/^\S*/).match(line)
      @prefix = @prefix.to_s
      add_to_hash
    end
    @prefix_hash = Hash[@prefix_hash.sort_by { |k, v| v }.reverse]
    File.open('./histogram.txt', 'w') do |file|
      @prefix_hash.each { |k, v| file.write("#{k} #{v}" + "\n") }
    end
  end
end

# test = PrefixHash.new.find_prefix('./raw_customers.txt')
