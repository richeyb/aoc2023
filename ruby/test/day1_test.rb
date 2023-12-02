require "day1.rb"
require "minitest/autorun"

class TestDay1 < Minitest::Test
  def setup
    @day = Day1.new
  end

  def test_day1_control
    input = File.read("inputs/day1/part1_control.txt")
    assert_equal @day.part1(input), 142
  end

  def test_day1_test
    input = File.read("inputs/day1/day1_test.txt")
    assert_equal @day.part1(input), 54605
  end

  def test_day2_control
    input = File.read("inputs/day1/part2_control.txt")
    assert_equal @day.part2(input), 281
  end

  def test_day2_test
    input = File.read("inputs/day1/day1_test.txt")
    assert_equal @day.part2(input), 55429
  end
  
end