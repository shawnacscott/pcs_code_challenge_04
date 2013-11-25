print 'prefix,first_name,middle,last_name,suffix,phone_number,phone_extension'

prefix_words = File.open('./prefix_words.txt', 'r').to_a
prefix_words.map! { |prefix| prefix.chomp }

while line = gets
  prefix = (/^\S*/).match(line)
  first_name = ""
  middle_name = ""
  last_name = ""
  suffix = ""
  phone_number = ""
  phone_extension = ""
  puts "#{prefix},#{first_name},#{middle_name},#{last_name},#{suffix},#{phone_number},#{phone_extension}"
end
