require './spec_helper.rb'

describe 'prefixes histogram' do

  it 'can access the raw_customers.txt file' do
    expect(File).to exist('../raw_customers.txt')
  end

  it 'creates a hash of prefixes' do
    (PrefixHash.new.prefix_hash).empty?
  end

  it 'outputs a file of prefixes'
end
