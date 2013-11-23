    
print "prefix, first_name, middle, last_name, suffix, phone_number, phone_extension"

    while line = gets
      prefix = (/^\S*/).match(line)
      first_name = ""
      middle_name = ""
      # [middle_name | middle_initial] = ""
      last_name = ""
      suffix = ""
      phone_number = ""
      phone_extension = ""
      puts "#{prefix}, #{first_name}, #{middle_name}, #{last_name}, #{suffix}, #{phone_number}, #{phone_extension}"
    end
