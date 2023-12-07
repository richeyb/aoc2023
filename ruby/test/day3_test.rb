require "day3"
require "minitest/autorun"

class TestDay3 < Minitest::Test
  def test_day3_control
    day = Day3.new("inputs/day3/part1_control.txt")
    assert_equal 4361, day.part1()
  end

  def test_day3_control_part2
    day = Day3.new("inputs/day3/part1_control.txt")
    assert_equal 467835, day.part2()
  end

  def test_day3_test
    day = Day3.new("inputs/day3/day3_test.txt")
    assert_equal 540025, day.part1()
  end

  def test_day3_test_part2
    day = Day3.new("inputs/day3/day3_test.txt")
    assert_equal 84584891, day.part2()
  end
end