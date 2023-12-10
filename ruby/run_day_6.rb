require './lib/day6.rb'

day = Day6.new
puts "Control:"
puts "\tWins: #{day.get_wins("./inputs/day6/control.txt")}"

puts "Test:"
puts "\tWins: #{day.get_wins("./inputs/day6/test.txt")}"

puts "\n\nPART 2\n\n"

puts "Control:"
puts "\tWins: #{day.part2("./inputs/day6/control.txt")}"

puts "Test:"
puts "\tWins: #{day.part2("./inputs/day6/test.txt")}"