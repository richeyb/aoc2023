require "day5"
require "minitest/autorun"

class TestDay5 < Minitest::Test
  def test_control
    day = Day5.new("inputs/day5/control.txt")
    seed = day.part1()
    assert_equal 35, seed
  end

  def test_part1
    day = Day5.new("inputs/day5/test.txt")
    seed = day.part1()
    assert_equal 462648396, seed
  end

  def test_control_part2
    day = Day5.new("inputs/day5/control.txt")
    seed = day.part2()
    assert_equal 46, seed
  end

  def test_part2
    day = Day5.new("inputs/day5/test.txt")
    seed = day.part2_reversed()
    assert_equal 2520479, seed
  end
end