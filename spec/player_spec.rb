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


end