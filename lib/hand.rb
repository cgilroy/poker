require_relative './poker_hands'
class Hand
    include PokerHands
    attr_reader :cards
    def initialize(cards)
        raise 'Hands must have 5 cards' if cards.count != 5
        @cards = cards.sort
    end

    def swap_cards(old_cards,new_cards)
        raise 'Improper card counts' unless old_cards.length == new_cards.length && old_cards.length < 6
        raise 'Cannot swap a card you do not have' unless old_cards.all? { |card| @cards.include?(card) }
        new_cards.each { |card| @cards <<  card}
        old_cards.each { |card| @cards.delete(card) }
    end

    def sort!
        @cards.sort!
    end

    def self.winner(hands)
        hands.sort.last
    end
end