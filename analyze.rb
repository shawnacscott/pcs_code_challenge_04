class PrefixHash
  attr_reader :prefix_hash

  def initialize
    @prefix_hash = Hash.new(0)
    @prefix = ''
  end

end