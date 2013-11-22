require './spec_helper.rb'

describe 'test the clean file output' do

  it 'can access the customers.csv file' do
    expect(File).to exist('../customers.csv')
  end

  
end
