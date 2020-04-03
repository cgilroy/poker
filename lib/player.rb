
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

    def fold
        @folded = true
    end

    def reset_fold
        @folded = false
    end

    def folded?
        @folded
    end

    def reset_bet
        @curr_bet = 0
    end

    def bet_response
        puts "Do you call bet or fold? (c/b/f)"
        resp = gets.chomp.downcase
        case resp
        when 'c' then :call
        when 'b' then :bet
        when 'f' then :fold
        else
            puts 'Invalid character'
            bet_response
        end
    end

    def get_bet
        puts "Bet amount (you have $#{chip_count}"
        amount = gets.chomp.to_i
        raise 'insufficient funds' if bet > chip_count
        amount
    end
end