require 'pp'

class Day5
  def initialize()
    #lines = File.readlines(filename)
    @seeds = [79, 14, 55, 13]
    #@seeds = [49, 50, 51, 52]
    @seeds.each do |seed|
      path = []
      seed_to_soil_map = [[50, 98, 2], [52, 50, 48]]
      soil_to_fertilizer = [[0, 15, 37], [37, 52, 2], [39, 0, 15]]
      fertilizer_to_water = [[49, 52, 8], [0, 11, 42], [42, 0, 7], [57, 7, 4]]
      water_to_light = [[88, 18, 7], [18, 25, 70]]
      light_to_temperature = [[45, 77, 23], [81, 45, 19], [68, 64, 13]]
      temperature_to_humidity = [[0, 69, 1], [1, 0, 69]]
      humidity_to_location = [[60, 56, 37], [56, 93, 4]]
      puts "Seed to Soil Map:\n------------------------------\n"
      path << map_converter(seed_to_soil_map, seed)
      puts "\n\nSoil to Fertilizer Map\n------------------------------\n"
      path << map_converter(soil_to_fertilizer, path.last)
      # puts "\n\nFertilizer to Water\n------------------------------\n"
      # path << map_converter(fertilizer_to_water, [path.last])
      # puts "\n\nWater to Light\n------------------------------\n"
      # path << map_converter(water_to_light, [path.last])
      # puts "\n\nLight to Temperature\n------------------------------\n"
      # path << map_converter(light_to_temperature, [path.last])
      # puts "\n\nTemperature to Humidity\n------------------------------\n"
      # path << map_converter(temperature_to_humidity, [path.last])
      # puts "\n\Humidity to Location\n------------------------------\n"
      # path << map_converter(humidity_to_location, [path.last])
      pp path
    end
  end

  def map_converter(lines, seed)
    # lines = [[50, 98, 2]]
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
  end
end