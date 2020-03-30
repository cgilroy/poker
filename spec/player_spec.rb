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

end