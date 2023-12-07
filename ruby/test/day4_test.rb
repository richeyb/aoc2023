require "day4"
require "minitest/autorun"

class TestDay4 < Minitest::Test
  def setup
    @day = Day4.new
  end

  def test_day1_control
    @day.read_file("inputs/day4/control.txt")
    assert_equal 13, @day.part1()
  end

  def test_day1_test
    @day.read_file("inputs/day4/test.txt")
    assert_equal 18653, @day.part1()
  end

  def test_day1_control_part2
    @day.read_file("inputs/day4/control.txt")
    assert_equal 30, @day.part2()
  end

  def test_day1_test_part2
    @day.read_file("inputs/day4/test.txt")
    assert_equal 5921508, @day.part2()
  end
  
end