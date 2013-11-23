require 'optparse'
require 'CSV'

# Clean and split data from raw_customers.txt
class CleanedData
  def initialize
    @csv_array = []
  end

  def create_csv
    File.open('../raw_customers.txt', 'r') do |file|
      file.each { |line| @csv_array << [line] }
    end
    CSV.open('../customers.csv', 'w') do |csv|
      @csv_array.each { |line| csv << line }
    end
  end
end

# CleanedData.new.create_csv
