histogram = Hash.new(0)

while line = gets
  prefix = (/^\S*/).match(line).to_s
  histogram[prefix.to_sym] += 1
end

histogram = Hash[histogram.sort_by { |prefix, count| count }.reverse]
histogram.each { |prefix, count| puts "#{prefix} #{count}" }
