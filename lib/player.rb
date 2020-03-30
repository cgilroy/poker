
class Player
    attr_reader :chip_count, :hand, :curr_bet
    def initialize(buy_in)
        @chip_count = buy_in
        @hand = nil
        @curr_bet = 0
    end

    def get_hand(hand)
        @hand = hand
    end

    def make_bet(total_bet)
        bet_tot = total_bet - @curr_bet
        raise 'insufficient funds' unless bet_tot <= chip_count
        @curr_bet = total_bet
        @chip_count -= bet_tot
    end

    def collect_winnings(winnings)
        @chip_count += winnings
    end

    def return_cards
        return_cards = @hand.cards
        @hand = nil
        return_cards
    end
end