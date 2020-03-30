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

        it 'should give the players the chips specified' do
            game.setup_game(4,20)
            expect( game.players.all? { |player| player.chip_count == 20 }).to be(true)
        end
    end

    describe '#deal_hands' do
        before(:each) do
            game.setup_game(3,20)
        end

        it 'should give each player a hand' do
            game.deal_hands
            expect( game.players.all? { |player| !player.hand.nil? } ).to be(true)
        end

        it 'should only deal hands to players with chips' do
            game.setup_game(1,0)
            game.deal_hands
            expect( game.players.last.hand ).to be(nil)
        end
    end

    describe '#add_cash_to_pot' do
        it 'should add money to the pot' do 
            expect { game.add_cash_to_pot(20) }.to change {game.pot}.by(20)
        end
    end

    describe '#game_over?' do
        it 'should return true when only one player has chips' do
            game.setup_game(2,0)
            game.setup_game(1,20)
            expect(game.game_over?).to be(true)
        end
    end

    describe '#round_over?' do
        it 'should end when only one player has not folded' do
            game.setup_game(3,20)
            game.reset_round
            game.players[0..1].each(&:fold)
            expect(game.round_over?).to be(true)
        end
    end

end 