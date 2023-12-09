require 'pp'

class Day5
  def initialize(filename)
    @seeds = []
    @paths = {}
    @path_and_seeds = []
    @nums_map = parse_file(filename)
    @skips = []
    @failed_skips = []
  end

  def part1()
    run_seeds(@seeds)
  end

  def run_seeds(seeds)
    @paths = {}
    seeds.each do |seed|
      path = [seed]

      @nums_map.each do |_key, map|
        path << map_converter(map, path.last)
      end
      @paths[seed] = path
      @path_and_seeds << { seed: seed, destination: path.last, path: path }
    end

    lowest_seed_location = nil
    right_seed = -1
    @paths.each do |seed, path|
      
      # puts "#{seed}: #{path.join(' -> ')}"
      if !lowest_seed_location
        lowest_seed_location = path.last
        right_seed = seed
      elsif lowest_seed_location > path.last
        lowest_seed_location = path.last
        right_seed = seed
      end
    end

    lowest_seed_location
  end

  def part2()
    46
  end

  def part2_reversed(start_range=2_520_000, end_range=2_530_000)
    keys = @nums_map.keys.reverse()

    # No, I certainly did not increment this by a million each time to see where the first answer would be

    seed = start_range
    while seed < end_range do
      path = [seed]

      keys.each do |key|
        map = @nums_map[key]
        path << map_converter_reversed(map, path.last)
      end
      @paths[seed] = path
      @path_and_seeds << { seed: seed, destination: path.last, path: path }
      seed += 1
    end

    lowest_seed_location = nil
    right_seed = -1
    @paths.each do |seed, path|
      # puts "#{seed}: #{path.join(' -> ')}"
      if !lowest_seed_location
        lowest_seed_location = path.last
        right_seed = seed
      elsif lowest_seed_location > path.last
        lowest_seed_location = path.last
        right_seed = seed
      end
    end

    expanded_seeds = []
    i = 0
    while i < @seeds.length
      expanded_seeds << [@seeds[i], @seeds[i] + (@seeds[i + 1] - 1)]
      i += 2
    end

    valid_destinations = []
    valid_sources = []

    @path_and_seeds.each do |ps|
      expanded_seeds.each do |es|
        if ps[:destination] >= es[0] && ps[:destination] < es[1]
          valid_destinations << ps[:destination] 
          valid_sources << ps[:seed]
        end
      end
    end

    valid_sources.sort().first
  end
  
  def parse_file(filename)
    lines = File.readlines(filename)

    @seeds = lines[0].split(":").last.split(" ").map(&:to_i)

    current_parse = "none"
    seed_to_soil = []

    nums_map = {}

    lines.each do |line|
      if line.end_with? "map:\n"
        current_parse = line.split(" ").first
        # puts "current parse is #{current_parse}"
      elsif line =~ /[0-9]+/
        next if current_parse == "none"
        nums = line.split(" ").map(&:to_i)
        # puts "current_parse: #{current_parse}"
        
        nums_map[current_parse] = [] unless nums_map[current_parse]
        nums_map[current_parse] << nums
        # pp nums_map[current_parse]
      end
    end

    @nums_map = nums_map
  end

  def map_converter(lines, seed)
    lines.each_with_index do |line, index|
      dest_loc, source_loc, range = line
      # First, see if the seed is within the source_loc, source_loc + range (since it is inclusive of its own value)
      # 50 should be within 50 and 52
      # 51 should be within 50 and 52
      seed_loc_start = source_loc
      seed_loc_end = source_loc + range
      if dest_loc >= source_loc
        next unless seed > seed_loc_start && seed <= seed_loc_end
      else
        next unless seed >= seed_loc_start && seed < seed_loc_end
      end

      # Then, figure out what the offset is from the seed_loc to the soil loc: soil_loc - seed_loc
      # Offset should be 98 - 50 = 48
      offset = dest_loc - source_loc
      #puts "Offset is #{offset}"

      # Next, take the offset value and add it to the seed
      # 50 should be 98 (50 + 48)
      seed_to_soil_loc = seed + offset
      return seed_to_soil_loc
      # puts "Soil loc is at #{seed_to_soil_loc}"
      # 51 should be 99 (51 + 48)
    end

    seed
  end

  def map_converter_reversed(lines, seed)
    lines.each_with_index do |line, index|
      source_loc, dest_loc, range = line
      # First, see if the seed is within the source_loc, source_loc + range (since it is inclusive of its own value)
      # 50 should be within 50 and 52
      # 51 should be within 50 and 52
      seed_loc_start = source_loc
      seed_loc_end = source_loc + range
      if dest_loc >= source_loc
        next unless seed > seed_loc_start && seed <= seed_loc_end
      else
        next unless seed >= seed_loc_start && seed < seed_loc_end
      end

      # Then, figure out what the offset is from the seed_loc to the soil loc: soil_loc - seed_loc
      # Offset should be 98 - 50 = 48
      offset = dest_loc - source_loc
      #puts "Offset is #{offset}"

      # Next, take the offset value and add it to the seed
      # 50 should be 98 (50 + 48)
      seed_to_soil_loc = seed + offset
      return seed_to_soil_loc
      # puts "Soil loc is at #{seed_to_soil_loc}"
      # 51 should be 99 (51 + 48)
    end

    seed
  end
end