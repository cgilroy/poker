require 'player'

describe Player do
    subject(:player) { Player.new(20) }

    describe '#initialize' do
        it 'should create a player with a chip-count equal to the buy-in' do
            expect(player.chip_count).to eq(20)
        end
    end

    describe '#get_hand' do
        let(:hand) { double ('hand') }
        it 'should give the player a hand' do
            player.get_hand(hand)
            expect(player.hand).to eq(hand)
        end
    end


    describe '#make_bet' do
        it 'should reduce the players chip count by the bet amounts (when on first bets)' do
            expect{ player.make_bet(2) }.to change { player.chip_count }.by(-2)
        end

        it 'should only remove cash from the player to reach the total bet amount' do
            player.make_bet(5)
            expect{ player.make_bet(8) }.to change { player.chip_count }.by(-3)
        end

        it 'should raise an error if you bet more than you have' do
            expect { player.make_bet(25) }.to raise_error 'insufficient funds'
        end
    end

    describe '#collect_winnings' do
        it 'should add the winnings to the palyers chip count' do
            expect { player.collect_winnings(5) }.to change { player.chip_count }.by(5)
        end
    end

    describe '#return_cards' do
        let(:hand) { double('hand') }
        let(:cards) { double('cards') }

        before(:each) do
            player.get_hand(hand)
            allow(hand).to receive(:cards).and_return(cards)
        end

        it 'should return the cards to the deck' do
            expect(player.return_cards).to eq(cards)
        end

        it 'should set the hand to nil' do
            player.return_cards
            expect(player.hand).to be(nil)
        end
    end

    describe '#fold' do
        it 'should set the players folded? attribute to true' do
            player.fold
            expect(player).to be_folded
        end
    end

    describe '#folded?' do
        it 'should return true if player has folded' do
            player.fold
            expect(player.folded?).to be(true)
        end
    end

    describe '#reset_fold' do
        it 'should set folded? to false' do
            player.fold
            player.reset_fold
            expect(player).to_not be_folded
        end
    end

end