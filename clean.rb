require 'optparse'

class Cleaned

    def createCSV
        File.open('./raw_customers.txt', 'r') do |file|
            file.each { |line| file.write('./customers.csv')}
        end
    end

end

test = Cleaned.new.createCSV



# ruby clean.rb --prefixes prefix_words.txt --input raw_customers.txt --output customers.csv
# ruby clean.rb -p prefix_words.txt -i raw_customers.txt -o customers.csv
# ruby clean.rb -h 
# ruby clean.rb --help




