

class Card
    attr_reader :suit, :value
    SUITS = [:diamond,:spade,:club,:heart]
    VALUES = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king]
    def initialize(suit,value)
        raise "Invalid suit" unless SUITS.include?(suit)
        raise "Invalid value" unless VALUES.include?(value)
        @suit = suit
        @value = value
    end

end