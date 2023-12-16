require "pp"

scores = [16, 8, 4, 2, 1]

class Day7
  def initialize(input_filename:)
    @face_ranks = {
      'A' => 14,
      'K' => 13,
      'Q' => 12, 
      'J' => 1,
      'T' => 10,
    }

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
      max_card = -1
      hand.split("").each do |card|
        cards[card] ||= 0
        cards[card] += 1
        max_card = [max_card, parse_face_rank(card)].max
      end
      top_card = cards.sort_by { |k, v| -v }.first.first
      unless cards["J"] == 5
        j_cards = (cards["J"] || 0)
        #puts "giving all of J (#{j_cards}) to #{top_card} (#{cards[top_card]})"
        cards[top_card] += j_cards
        cards["J"] = 0
      else
        #puts "all cards are j"
      end
      results = parse_for_hands(cards)
      pp results
      hands << { hand: hand, bid: bid, results: results, cards: cards, max_card: max_card, hand_value: hand_value(results), hex_value: convert_to_hex_value(hand), print_hand_value: print_hand_value(results) }
    end
    sorted_hands = hands.sort_by { |hand| [hand[:hand_value], hand[:hex_value]] }
    total_score = 0
    sorted_hands.each_with_index do |hand, index|
      points = hand[:bid].to_i * (index + 1)
      total_score += points
      puts "#{hand[:hand]} rank: #{index + 1} bid: #{hand[:bid]} hand value: #{hand[:print_hand_value]} score: #{points}"
    end
    total_score
  end

  def parse_face_rank(card)
    return @face_ranks[card] if @face_ranks[card]
    card.to_i()
  end

  def hand_value(hand)
    return 6 if hand[:five_of_a_kind]
    return 5 if hand[:four_of_a_kind]
    return 4 if hand[:full_house]
    return 3 if hand[:three_of_a_kind]
    return 2 if hand[:two_pair]
    return 1 if hand[:one_pair]
    return 0
  end

  def print_hand_value(hand)
    return "Five of a Kind" if hand[:five_of_a_kind]
    return "Four of a Kind" if hand[:four_of_a_kind]
    return "Full House" if hand[:full_house]
    return "Three of a Kind" if hand[:three_of_a_kind]
    return "Two Pair" if hand[:two_pair]
    return "One Pair" if hand[:one_pair]
    "Max Card"
  end

  # def jcount(card, cards)
  #   return 0 if card == "J"
  #   cards["J"] || 0
  # end

  def parse_for_hands(cards)
    five_of_a_kind = false
    four_of_a_kind = false
    full_house = false
    full_house_cards = Set.new()
    three_of_a_kind = false
    three_of_a_kind_cards = Set.new()
    two_pair = false
    two_pair_cards = Set.new()
    one_pair = false
    high_card = false
    cards.keys.each do |key|
      if cards[key] == 5
        five_of_a_kind = true
      end
      if cards[key] == 4
        four_of_a_kind = true
      end
      if cards[key] == 3
        three_of_a_kind = true
      end
      if cards[key] == 2
        two_pair_cards.add(key)
        two_pair = true if two_pair_cards.count() >= 2
        one_pair = true
      end
    end
    # non_joker_keys = cards.keys.reject { |k| k == "J" }.uniq
    if one_pair && three_of_a_kind
      full_house = true
    end

    if !five_of_a_kind && !four_of_a_kind && !three_of_a_kind && !full_house && !two_pair && !one_pair
      high_card = true
    end
    # if cards.keys == ["J"]
    #   return {
    #     five_of_a_kind: false,
    #     four_of_a_kind: false,
    #     full_house: false,
    #     three_of_a_kind: false,
    #     two_pair: false,
    #     one_pair: false,
    #     high_card: false
    #   }
    # end
    {
      five_of_a_kind: five_of_a_kind,
      four_of_a_kind: four_of_a_kind,
      full_house: full_house,
      three_of_a_kind: three_of_a_kind,
      two_pair: two_pair,
      one_pair: one_pair,
      high_card: high_card
    }
  end
end