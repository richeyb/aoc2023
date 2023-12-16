require './lib/day7.rb'

puts "--------------- CONTROL ---------------"
day = Day7.new(input_filename: "inputs/day7/control.txt")
score = day.parse_poker()
puts "Total score: #{score}\n\n\n"

puts "--------------- TEST ---------------"
day = Day7.new(input_filename: "inputs/day7/test.txt")
# day = Day7.new(input_filename: "inputs/day7/special_test.txt")
score = day.parse_poker()
# puts "Total score: #{score} (SHOULD BE: 250757288)\n\n\n"