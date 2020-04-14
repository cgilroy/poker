class Card
    include Comparable
    attr_reader :suit, :value
    SUITS = [:club,:diamond,:heart,:spade]
    VALUES = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king, :ace]
    SUIT_SYMBOLS = {
        :club => "♣",
        :diamond => "♦",
        :heart => "♥",
        :spade => "♠"
    }

    VALUE_SYMBOLS = {
        :two   => "2",
        :three => "3",
        :four  => "4",
        :five  => "5",
        :six   => "6",
        :seven => "7",
        :eight => "8",
        :nine  => "9",
        :ten   => "10",
        :jack  => "J",
        :queen => "Q",
        :king  => "K",
        :ace   => "A"
    }

    def initialize(suit,value)
        raise "Invalid suit" unless SUITS.include?(suit)
        raise "Invalid value" unless VALUES.include?(value)
        @suit = suit
        @value = value
    end

    def to_s
        VALUE_SYMBOLS[value] + SUIT_SYMBOLS[suit]
    end

    def ==(card)
        return true if card.value == @value && card.suit == @suit
        false
    end

    def <=>(card)
        my_index = VALUES.index(@value)
        test_index = VALUES.index(card.value)
        return 0 if card == self
        if my_index != test_index then
            my_index <=> test_index
        elsif suit != card.suit then
            SUITS.index(suit) <=> SUITS.index(card.suit)
        end
    end

    def self.royal_values
        [:ten,:jack,:queen,:king,:ace]
    end

    def self.values
        VALUES
    end 

end