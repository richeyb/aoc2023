require 'pp'

class Day4
  def initialize
    @input = nil
    @cards = []
    @slots = []
  end

  def read_file(input_file)
    @input = File.read(input_file).split("\n")
    @input.each do |line|
      win_number = {}
      title, numbers = line.split(":").map(&:chomp)
      winning_numbers, card_numbers = numbers.split("|").map(&:chomp)
      winning_numbers = winning_numbers.split(" ").map(&:chomp)
      card_numbers = card_numbers.split(" ").map(&:chomp)

      matches = 0
      winning_numbers.each { |num| win_number[num] = true }
      card_numbers.each { |num| matches += 1 if win_number[num] }

      @cards << { title: title, winning_numbers: winning_numbers, card_numbers: card_numbers, matches: matches }
    end
    @slots = [1] * @cards.length
  end

  def part1
    results = {}
    # pp @input
    @cards.each do |card|
      if card[:matches] <= 0
        results[card[:title]] = 0
      else
        results[card[:title]] = [2 ** (card[:matches] - 1), 1].max
      end
    end
    sum_of_cards(results)
  end

  def part2
    index = 0
    while index < @slots.length
      times = @slots[index]
  
      card = @cards[index]
      times.times do
        j = [index + card[:matches], @slots.length].min
        while j > index
          @slots[j] += 1
          j -= 1
        end
      end
      index += 1
    end
    @slots.sum
  end

  def sum_of_cards(results)
    sum = 0
    results.each do |_, value|
      sum += value
    end
    sum
  end
end