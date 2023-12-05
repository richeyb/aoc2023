require 'pp'

class Day3
  def initialize(filename)
    input = File.read(filename)
    @grid = []
    input.split("\n").each do |line|
      @grid.append([])
      line.split("").each do |c|
        @grid.last.append(c)
      end
    end
  end

  def numeric?(c)
    Integer(c) != nil rescue false
  end

  def part1()
    scan_for_numbers[:sum]
  end

  def part2(  )
    scan_for_numbers[:gear_values]
  end

  def scan_for_numbers
    good_numbers = []
    bad_numbers = []
    gear_numbers = {}
    number_start = false
    x = 0
    y = 0
    gear_values = []
    
    while y < @grid.length
      while x < @grid[y].length
        if numeric?(@grid[y][x])
          result = grab_number(x, y)
          if result[:near_symbol]
            good_numbers << result[:number]
            if result[:near_gear]
              key = "(#{result[:nearest_gear][0]},#{result[:nearest_gear][1]})"
              gear_numbers[key] = [] if !gear_numbers[key]
              gear_numbers[key] << result[:number]
            end
          else
            bad_numbers << result[:number]
          end
          x = result[:pos]
        else
          x += 1
        end
      end
      x = 0
      y += 1
    end

    gear_numbers.each do |key, values|
      gear_values << values.reduce(:*) if values.length > 1
    end

    { sum: good_numbers.sum, gear_values: gear_values.sum }
  end

  def grab_number(x, y)
    buffer = []
    nearest_gear = []
    is_symbol_adjacent = false
    is_gear_adjacent = false
    nx = x

    while nx < @grid[y].length do
      break if !numeric?(@grid[y][nx])
      buffer << @grid[y][nx]
      unless is_symbol_adjacent
        # Only scan if we need to scan
        res = scan_with_check(nx, y) { |str| is_symbol?(str) }
        is_symbol_adjacent = res[:check]
        res = scan_with_check(nx, y) { |str| is_gear?(str) }
        if res[:check]
          is_gear_adjacent = true
          nearest_gear = res[:coord]
        end
      end
      nx += 1
    end
    # puts "Buffer is #{buffer.join()}: near_symbol: #{is_symbol_adjacent}, near_gear: #{is_gear_adjacent}, nearest_gear: #{nearest_gear}"
    { number: Integer(buffer.join()), pos: nx, near_symbol: is_symbol_adjacent, near_gear: is_gear_adjacent, nearest_gear: nearest_gear }
  end

  def is_symbol?(str)
    str !~ /[0-9\.]/
  end

  def is_gear?(str)
    str == '*'
  end

  def is_number?(str)
    str =~ /[0-9]/
  end

  def scan_with_check(x, y, &block)
    # check NW
    if y > 0 && x > 0 && yield(@grid[y - 1][x - 1])
      return { check: true, coord: [x - 1, y - 1] }
    end
    # check N
    if y > 0 && yield(@grid[y - 1][x])
      return { check: true, coord: [x, y - 1] }
    end
    # check NE
    if y > 0 && x < @grid[y - 1].length - 1&& yield(@grid[y - 1][x + 1])
      return { check: true, coord: [x + 1, y - 1] }
    end
    # check E
    if x < @grid[y - 1].length - 1 && yield(@grid[y][x + 1])
      return { check: true, coord: [x + 1, y] }
    end
    # check SE
    if y < @grid.length - 1 && x < @grid[y + 1].length - 1 && yield(@grid[y + 1][x + 1])
      return { check: true, coord: [x + 1, y + 1] }
    end
    # check S
    if y < @grid.length - 1 && yield(@grid[y + 1][x])
      return { check: true, coord: [x, y + 1] }
    end
    # check SW
    if y < @grid.length - 1 && x > 0 && yield(@grid[y + 1][x - 1])
      return { check: true, coord: [x - 1, y + 1] }
    end
    # check W
    if x > 0 && yield(@grid[y][x - 1])
      return { check: true, coord: [x - 1, y] }
    end

    # We didn't find anything
    return { check: false, coord: nil }
  end
end