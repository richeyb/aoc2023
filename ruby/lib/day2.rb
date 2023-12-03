require 'pp'

class Day2
  def initialize()
    @games = {}
  end

  def read_file(file)
    lines = File.readlines(file)
    lines.each do |line|
      game_name, game_output = line.split(":").map(&:chomp)
      draws = game_output.split(";").map(&:chomp)

      max = {
        red: 0,
        green: 0,
        blue: 0,
      }
      total_gems = 0
      hands = draws.map do |draw|
        scores = draw.split(",").map(&:chomp)
        game_scores = {}
        total_gems = 0
        scores.each do |score|
          number, color = score.split(" ")
          number = Integer(number) rescue 0
          color = color.chomp.downcase.to_sym
          game_scores[color] = number
          max[color] = [max[color], number].max
          total_gems += number
        end
        game_scores
      end
      @games[game_name] = { hands: hands, max_red: max[:red], max_blue: max[:blue], max_green: max[:green], total_gems: total_gems }
    end
    # pp @games
  end

  def get_sum_of_possible_games(red=0, blue=0, green=0)
    sum = 0
    @games.each do |game_name, game|
      if game[:max_red] <= red && game[:max_green] <= green && game[:max_blue] <= blue
        game_name, game_number = game_name.split(" ")
        sum += Integer(game_number)
      end
    end
    sum
  end

  def get_power_of_games
    sum_of_power = 0
    @games.each do |game_name, game|
      power = game[:max_red] * game[:max_green] * game[:max_blue]
      sum_of_power += power
    end
    sum_of_power
  end
end