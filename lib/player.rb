
class Player
    attr_reader :chip_count, :hand, :curr_bet
    include Comparable
    def initialize(buy_in)
        @chip_count = buy_in
        @hand = nil
        @curr_bet = 0
    end

    def <=>(compare_player)
        hand <=> compare_player.hand
    end

    def get_hand(hand)
        @hand = hand
    end

    def make_bet(total_bet)
        bet_tot = total_bet - @curr_bet
        raise 'insufficient funds' unless bet_tot <= chip_count
        @curr_bet = total_bet
        @chip_count -= bet_tot
        bet_tot
    end

    def collect_winnings(winnings)
        @chip_count += winnings
    end

    def return_cards
        return_cards = @hand.cards
        @hand = nil
        return_cards
    end

    def get_swapped_cards
        puts "Please enter the indices of the cards (separated by a space)"
        indices = gets.chomp.split(' ').map(&:to_i)
        raise 'Invalid index' if indices.any? { |val| val > 9 || val < 0 }
        raise 'Only select three cards max' if indices.count > 3
        indices.map { |idx| hand.cards[idx-1] }
    end

    def swap_cards(old_cards,new_cards)
        hand.swap_cards(old_cards,new_cards)
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
        puts "Bet amount (you have $#{chip_count})"
        amount = gets.chomp.to_i
        raise 'insufficient funds' if amount > chip_count
        amount
    end
end