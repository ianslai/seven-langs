phrase = ARGV[0]
file = ARGV[1]

raise "Missing arguments. Usage: #{$0} phrase filename" unless phrase && file

File.foreach(file).with_index do |line, index|
  puts "#{index + 1}: #{line}" if line.include?(phrase)
end
