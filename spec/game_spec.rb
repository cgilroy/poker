require 'game'

describe Game do
    subject(:game) { Game.new }
    describe "#initialize" do
        it 'should set up an empty array of players' do
            expect(game.players).to be_a(Array)
            expect(game.players.length).to be(0)
        end
        
        it 'should create an empty pot' do
            expect(game.pot).to be(0)
        end
        
        it 'should create a (full) deck' do
            expect(game.deck).to be_a(Deck)
            expect(game.deck.cards.count).to eq(52)
        end
    end

    describe '#setup_game' do
        it 'should make a game with a certain number of players' do
            game.setup_game(4,20)
            expect(game.players.length).to be(4)
        end
    end

end 