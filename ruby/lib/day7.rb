require "pp"

scores = [16, 8, 4, 2, 1]

class Day7
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
      hand.split("").each do |card|
        cards[card] ||= 0
        cards[card] += 1
      end
      results = parse_for_hands(cards)
      hands << { hand: hand, bid: bid, results: results, cards: cards }
    end
    pp hands
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
        full_house_cards.add(key)
        full_house = true if full_house_cards.count() >= 2
        three_of_a_kind_cards.add(key)
        three_of_a_kind = true
      end
      if cards[key] == 2
        full_house_cards.add(key)
        full_house = true if full_house_cards.count() >= 2
        two_pair_cards.add(key)
        two_pair = true if two_pair_cards.count() >= 2
        one_pair = true
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