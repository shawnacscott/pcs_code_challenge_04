require './spec_helper.rb'

describe 'prefixes histogram' do

  it 'can access the raw_customers.txt file' do
    expect(File).to exist('../raw_customers.txt')
  end

  it 'creates a list of prefixes' do
    prefix_list = PrefixHash.new.find_prefix('../raw_customers.txt')
    (prefix_list).should_not be_empty
  end

  it 'outputs a file of prefixes' do
    File.read('../histogram.txt').should_not be_empty
  end
end
