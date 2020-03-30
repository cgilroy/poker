require 'player'

describe Player do
    subject(:player) { Player.new(20) }

    describe '#initialize' do
        it 'should create a player with a chip-count equal to the buy-in' do
            expect(player.chip_count).to eq(20)
        end
    end

    
end