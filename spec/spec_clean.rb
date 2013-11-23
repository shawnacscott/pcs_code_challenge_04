require './spec_helper.rb'

def test_name
    name_example = File.open'./input.txt', 'w'
    name_example.puts "Mr. Waylon Elisa Kozey-Kuhic III    776.953.9374"
    name_example.close
    expected_file = File.open 'spec/expected_output.txt', 'w'
    expected_file.puts "Mr., Waylon, Elisa, Kozey-Kuhic, III, +1.776.953.9374"
    expected_file.close
end


def delete_files
  FileUtils.rm %w( spec/input.txt spec/expected_output.txt spec/output.txt)
end

describe 'test the clean file output' do

    it "creates the output correctly" do
        test_name
        `ruby ../clean.rb < input.txt > output.txt`
        expect(FileUtils.identical? 'spec/expected_output.txt',
            'output.txt').to be_true
        delete_files
    end

end

