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

    describe '#swap_cards' do
        let(:cards_out) { hand.cards[0..1] }
        let(:cards_in) { [Card.new(:heart,:three),Card.new(:spade,:king)] }

        it 'removes the cards' do
            hand.swap_cards(cards_out,cards_in)
            expect(hand.cards).to_not include(*cards_out)
        end

        it 'includes the new cards' do
            hand.swap_cards(cards_out,cards_in)
            expect(hand.cards).to include(*cards_in)
        end

        it 'raises an error if swap does not end with 5 cards in the hand' do
            expect {hand.swap_cards(cards_out,[Card.new(:spade,:six)])}.to raise_error 'Improper card counts'
        end

        it 'raises an error if you try to discard a card you do not own' do
            expect do
                hand.swap_cards([Card.new(:diamond,:ten)],cards_in[0..0])
            end.to raise_error 'Cannot swap a card you do not have'
        end
    end
end