
class Hand
    def initialize(cards)
        raise 'Hands must have 5 cards' if cards.count != 5
    end
end