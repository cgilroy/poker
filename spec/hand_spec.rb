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

    describe 'poker hands' do
        let(:royal_flush) do
            Hand.new([
                Card .new(:spade, :ace),
                Card.new(:spade, :king),
                Card.new(:spade, :queen),
                Card.new(:spade, :jack),
                Card.new(:spade, :ten)
            ])
        end

        let(:straight_flush) do
            Hand.new([
                Card.new(:spade, :eight),
                Card.new(:spade, :seven),
                Card.new(:spade, :six),
                Card.new(:spade, :five),
                Card.new(:spade, :four)
            ])
        end

        let(:four_of_a_kind) do
            Hand.new([
                Card.new(:spade, :ace),
                Card.new(:heart, :ace),
                Card.new(:diamond, :ace),
                Card.new(:club, :ace),
                Card.new(:spade, :ten)
            ])
        end

        let(:full_house) do
            Hand.new([
                Card.new(:spade, :ace),
                Card.new(:club, :ace),
                Card.new(:spade, :king),
                Card.new(:heart, :king),
                Card.new(:diamond, :king)
            ])
        end

        let(:flush) do
            Hand.new([
                Card.new(:spade, :four),
                Card.new(:spade, :seven),
                Card.new(:spade, :ace),
                Card.new(:spade, :two),
                Card.new(:spade, :eight)
            ])
        end

        let(:straight) do
            Hand.new([
                Card.new(:heart, :king),
                Card.new(:heart, :queen),
                Card.new(:diamond, :jack),
                Card.new(:club, :ten),
                Card.new(:spade, :nine)
            ])
        end

        let(:three_of_a_kind) do
            Hand.new([
                Card.new(:spade, :three),
                Card.new(:diamond, :three),
                Card.new(:heart, :three),
                Card.new(:spade, :jack),
                Card.new(:spade, :ten)
            ])
        end

        let(:two_pair) do
            Hand.new([
                Card.new(:heart, :king),
                Card.new(:diamond, :king),
                Card.new(:spade, :queen),
                Card.new(:club, :queen),
                Card.new(:spade, :ten)
            ])
        end

        let(:one_pair) do
            Hand.new([
                Card.new(:spade, :ace),
                Card.new(:spade, :ace),
                Card.new(:heart, :queen),
                Card.new(:diamond, :jack),
                Card.new(:heart, :ten)
            ])
        end

        let(:high_card) do
            Hand.new([
                Card.new(:spade, :two),
                Card.new(:heart, :four),
                Card.new(:diamond, :six),
                Card.new(:spade, :nine),
                Card.new(:spade, :ten)
            ])
        end

        let(:hand_ranks) do
            [
                :royal_flush,
                :straight_flush,
                :four_of_a_kind,
                :full_house,
                :flush,
                :straight,
                :three_of_a_kind,
                :two_pair,
                :one_pair,
                :high_card
            ]
        end

        let!(:hands) do
            [
                royal_flush,
                straight_flush,
                four_of_a_kind,
                full_house,
                flush,
                straight,
                three_of_a_kind,
                two_pair,
                one_pair,
                high_card
            ]
        end

    end
end