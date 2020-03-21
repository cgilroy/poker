require 'rspec'
require 'hand'
require 'card'

describe Hand do

    let(:cards) {[
        Card.new(:heart, :two),
        Card.new(:diamond, :king),
        Card.new(:diamond, :ace),
        Card.new(:spade, :seven),
        Card.new(:club, :king)
    ]}
    subject(:hand) { Hand.new(cards) }

    describe '#initialize' do
        it 'only accepts arrays of 5 cards' do
            expect{ Hand.new(cards[0..2]) }.to raise_error 'Hands must have 5 cards'
            expect{ Hand.new([*cards,Card.new(:heart, :three)]) }.to raise_error 'Hands must have 5 cards'
        end
    end

end