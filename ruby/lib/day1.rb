class Day1
  # Optimizations: Make this a lazy scan; find the first left and the first right value
  # Exit there

  def numeric?(c)
    # Helper to make sure we have a digit
    Integer(c) != nil rescue false
  end

  def part1(input)
    # Start off with a zero
    sum = 0
    input.split("\n").map(&:chomp).each do |line|
      # Clean each line, then build an array of numbers in the line and grab the first and last
      numbers = []
      line.split("").each { |c| numbers << c if numeric?(c) }
      # Then add it all together
      sum += Integer("#{numbers.first}#{numbers.last}")
    end
    sum
  end

  def part2(input)
    # First we have to catch scenarios where we overlap letters
    replacers = [
      %w(zerone zeroone),
      %w(oneight oneeight),
      %w(twone twoone),
      %w(threeight threeeight),
      %w(fiveight fiveeight),
      %w(sevenine sevennine),
      %w(eightwo eighttwo),
      %w(eighthree eightthree),
      %w(nineight nineeight)
    ]
    replacers.each { |r| input.gsub!(r[0], r[1]) }
    # Then we replace the number words to numbers
    values = %w(zero one two three four five six seven eight nine)
    values.each_with_index { |v, i| input.gsub!(v, i.to_s) }
    # And then it's normalized enough for part 1 to solve
    part1(input)
  end
end