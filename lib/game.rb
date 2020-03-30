require_relative 'player'

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
end