require "day2"
require "minitest/autorun"

class TestDay2 < Minitest::Test
  def setup
    @day = Day2.new
  end

  def test_day2_control
    @day.read_file("inputs/day2/part1_control.txt")
    assert_equal @day.get_sum_of_possible_games(12, 14, 13), 8
  end

  def test_day2_test
    @day.read_file("inputs/day2/day2_test.txt")
    assert_equal @day.get_sum_of_possible_games(12, 14, 13), 2879
  end

  def test_day2_part2_control
    @day.read_file("inputs/day2/part1_control.txt")
    assert_equal @day.get_power_of_games, 2286
  end

  def test_day2_part2_control
    @day.read_file("inputs/day2/day2_test.txt")
    assert_equal @day.get_power_of_games, 65122
  end
end