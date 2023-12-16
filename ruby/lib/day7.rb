require 'pp'

class Day7
  def initialize(input_filename:)
    @input = File.readlines(input_filename)
  end

  def convert_to_hex_value(input)
    # T = A, J = B, Q = C, K = D, A = E
    # 32T3K -> 0x32A3D
    # input.gsub("A", "E").gsub("T", "A").gsub("J", "B").gsub("Q", "C").gsub("K", "D").hex
    input.gsub("A", "E").gsub("T", "A").gsub("J", "1").gsub("Q", "C").gsub("K", "D").hex
  end

  def parse_poker()
    hands = []
    @input.each do |line|
      hand, bid = line.split(" ").map(&:chomp)
      cards = {}
      hand.split("").each do |card|
        cards[card] ||= 0
        cards[card] += 1
      end
      sorted_cards = cards.sort_by { |k, v| -v }
      top_card = sorted_cards.first.first
      unless cards["J"] == 5
        cards[top_card] += (cards["J"] || 0)
        cards.delete("J")
      end
      sorted_cards_again = cards.sort_by { |k, v| -v }
      sets = sorted_cards_again.map(&:last).sort_by { |v| -v }
      pp (sets.map(&:to_s).join("")).sort()
    end
  end
end