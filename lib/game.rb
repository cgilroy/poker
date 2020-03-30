require_relative 'player'
require_relative 'deck'

class Game
    attr_reader :players, :pot, :deck
    def initialize
        @players = []
        @pot = 0
        @deck = Deck.new
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
end