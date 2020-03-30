
class Player
    attr_reader :chip_count, :hand
    def initialize(buy_in)
        @chip_count = buy_in
        @hand = nil
    end

    def get_hand(hand)
        @hand = hand
    end
end