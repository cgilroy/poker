require 'deck'

describe Deck do
    describe '#intialize' do
        subject(:deck) { Deck.new }
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
end