require_relative 'player'
require_relative 'deck'
require 'byebug'

class Game
    attr_reader :players, :pot, :deck
    def initialize
        @players = []
        @pot = 0
        @deck = Deck.new
    end

    def play_game
        until game_over?
            reset_round
            deal_hands
            get_player_bets
            swap_cards
            get_player_bets
        end
    end

    def end_round
        display_hands
        puts "WINNER"
        puts "#{winner.hand} takes the $#{pot} pot"
        winner.collect_winnings(pot)
        @pot = 0
        return_cards
    end

    def return_cards
        players.each { |player| @deck.return_cards(player.return_cards) }
    end

    def winner
        players.max
    end

    def display_hands
        puts "PLAYER HANDS"
        players.each do |player|
            if !player.folded? then
                puts "#{player.hand.rank}: #{player.hand}"
            end
        end
    end

    def reset_round
        @deck.shuffle
        @players.each(&:reset_fold)
    end

    def setup_game(num_players,buy_in)
        num_players.times do
            @players << Player.new(buy_in)
        end
    end

    def deal_hands
        @players.each do |player|
            if player.chip_count != 0 then
                player.get_hand(@deck.deal_hand)
            end
        end
    end

    def get_player_bets
        players.each { |player| player.reset_bet }
        highest_bet = 0
        no_raises_made = false
        last_bet_player = nil

        until no_raises_made
            no_raises_made = true
            players.each_with_index do |player,idx|
                break if last_bet_player == player || round_over?
                if !player.folded? then
                    begin resp = player.bet_response
                        case resp
                        when :call
                            add_cash_to_pot(player.make_bet(highest_bet))
                        when :bet
                            raise 'insufficient funds' if highest_bet > player.chip_count
                            last_bet_player = player
                            bet = player.get_bet
                            raise "bet must be $#{highest_bet} or more" unless bet >= highest_bet
                            amount = player.make_bet(bet)
                            highest_bet = bet
                            add_cash_to_pot(amount)
                            no_raises_made = false
                        when :fold
                            player.fold
                        end
                    rescue => e
                        puts "#{e.message}"
                        retry
                    end
                end
            end
        end
    end

    def swap_cards
        players.each_with_index do |player,idx|
            if !player.folded? then
                puts "Player #{idx+1}: Enter your cards to trade"
                puts player.hand
                trade_cards = player.get_swapped_cards
                deck.return_cards(trade_cards)
                player.swap_cards(trade_cards,deck.take_card(trade_cards.count))
            end
        end
    end

    def add_cash_to_pot(amt)
        @pot += amt
    end

    def round_over?
        return true if @players.count { |player| !player.folded? } == 1
        false
    end

    def game_over?
        return true if @players.count { |player| player.chip_count > 0 } == 1
        false
    end
end