require 'pp'

class Day6
  def get_wins(filename)
    lines = File.readlines(filename)
    # pp lines
    times = lines.first.split(":").last.split(" ").map(&:chomp).map(&:to_i)
    # pp times
    distance = lines.last.split(":").last.split(" ").map(&:chomp).map(&:to_i)
    win_log = []

    times.each_with_index do |time, index|
      puts "Game #{index}: #{time} To beat: #{distance[index]}"
      game = simulate(time)
      wins = 0
      game.each do |round|
        to_beat = distance[index]
        # puts "distance: #{round[:distance]} > #{to_beat}"
        wins += 1 if round[:distance] > to_beat
      end
      win_log << wins
    end

    win_log.reduce(&:*)
  end

  def simulate(ms_for_race)
    seconds_to_charge = 0
    i = 0
    tries = []
    while i < ms_for_race
      seconds_for_charge = i
      seconds_to_race = ms_for_race - seconds_for_charge
      distance = seconds_to_race * seconds_for_charge
      tries << { attempt: i, seconds_for_charge: seconds_for_charge, distance: distance }
      i += 1
    end

    # puts "Tries is:"
    # pp tries
    tries
  end

  def part2(filename)
    lines = File.readlines(filename)
    # pp lines
    times = [lines.first.split(":").last.split(" ").map(&:chomp).join("").to_i()]
    # pp times
    distance = [lines.last.split(":").last.split(" ").map(&:chomp).join("").to_i()]
    win_log = []

    times.each_with_index do |time, index|
      puts "Game #{index}: #{time} To beat: #{distance[index]}"
      game = simulate(time)
      wins = 0
      game.each do |round|
        to_beat = distance[index]
        # puts "distance: #{round[:distance]} > #{to_beat}"
        wins += 1 if round[:distance] > to_beat
      end
      win_log << wins
    end

    win_log.reduce(&:*)
  end
end