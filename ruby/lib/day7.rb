require "pp"

scores = [16, 8, 4, 2, 1]

class Day7
  def initialize()
    @face_ranks = {
      'A' => 14,
      'K' => 13,
      'Q' => 12, 
      'J' => 11,
      'T' => 10,
    }
  end

  def convert_to_hex_value(input)
    # T = A, J = B, Q = C, K = D, A = E
    # 32T3K -> 0x32A3D
    input.gsub("A", "E").gsub("T", "A").gsub("J", "B").gsub("Q", "C").gsub("K", "D").hex
  end
  
  def parse_poker()
  input = <<-EOF
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
EOF
    hands = []
    input.split("\n").each do |line|
      hand, bid = line.split(" ").map(&:chomp)
      cards = {}
      max_card = -1
      hand.split("").each do |card|
        cards[card] ||= 0
        cards[card] += 1
        max_card = [max_card, parse_face_rank(card)].max
      end
      results = parse_for_hands(cards)
      hands << { hand: hand, bid: bid, results: results, cards: cards, max_card: max_card, hand_value: hand_value(results), hex_value: convert_to_hex_value(hand) }
    end
    sorted_hands = hands.sort_by { |hand| [hand[:hand_value], hand[:hex_value]] }
    total_score = 0
    sorted_hands.each_with_index do |hand, index|
      points = hand[:bid].to_i * (index + 1)
      total_score += points
      puts "#{hand[:hand]} rank: #{index + 1} score: #{points}"
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
      five_of_a_kind = true if cards[key] == 5
      four_of_a_kind = true if cards[key] == 4
      if cards[key] == 3
        three_of_a_kind_cards.add(key)
        three_of_a_kind = true
        full_house = true if three_of_a_kind && one_pair
      end
      if cards[key] == 2
        two_pair_cards.add(key)
        two_pair = true if two_pair_cards.count() >= 2
        one_pair = true
        full_house = true if three_of_a_kind && one_pair
      end
    end
    if !five_of_a_kind && !four_of_a_kind && !three_of_a_kind && !full_house && !two_pair && !one_pair
      high_card = true
    end
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