require './spec_helper.rb'

describe 'test the clean file output' do

  it 'can access the customers.csv file' do
    expect(File).to exist('../customers.csv')
  end

  it 'has CSV content' do
    CleanedData.new.create_csv
    File.read('../customers.csv').should_not be_empty
  end
end
