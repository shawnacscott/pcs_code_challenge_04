require './spec_helper.rb'

def test_name
    name_example = File.open'./input.txt', 'w'
    name_example.puts "Mr. Waylon Elisa Kozey-Kuhic III    776.953.9374"
    name_example.close
    expected_file = File.open './expected_output.csv', 'w'
    expected_file.puts "Mr., Waylon, Elisa, Kozey-Kuhic, III, +1.776.953.9374"
    expected_file.close
end

def name_parts
  expected_output = CSV.read('./expected_output.csv')
  output = CSV.read('./output.csv')
  for (x = 0, x < expected_output.first.length, x += 1) do
    expected_output.first[x] == output.first[x]
    
  end

end

def delete_files
  FileUtils.rm_r %w( ./input.txt ./expected_output.csv ./output.csv)
end

describe 'test the clean file output' do
  after(:all) do
    delete_files
  end

    it "creates the output correctly" do
        test_name
        `ruby ../clean.rb < input.txt > output.csv`
        expect(FileUtils.identical? './expected_output.csv',
            './output.csv').to be_true
    end

    it "creates the output correctly" do
      test_name
      `ruby ../clean.rb < input.txt > output.csv`
      expect(name_parts).to be_true
    end

end


