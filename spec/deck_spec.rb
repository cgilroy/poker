require 'deck'

describe Deck do
    let(:deck) { Deck.new }
    describe '#intialize' do
        it 'should hold an array of 52 cards' do
            expect(deck.cards.length).to be(52)
        end

        it 'should only hold Card objects' do
            expect(deck.cards).to all(be_a(Card))
        end

        it 'should not contain any doubles' do
            expect(deck.cards.uniq.length).to be(deck.cards.length)
        end
    end

    describe '#shuffle' do
        it 'should rearrange the cards' do
            first_cards = deck.cards[0..4]
            
            bad_shuffle = (1..3).all? do
                deck.shuffle
                (0..4).all? { |iter| deck.cards[iter] == first_cards[iter] }
            end
            expect(bad_shuffle).to eq(false)
        end
    end
end