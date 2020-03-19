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

    let(:first_cards) { deck.cards[0..4] }

    describe '#shuffle' do
        it 'should rearrange the cards' do
            bad_shuffle = (1..3).all? do
                deck.shuffle
                (0..4).all? { |iter| deck.cards[iter] == first_cards[iter] }
            end
            expect(bad_shuffle).to eq(false)
        end
    end

    describe '#take_card' do
        it 'removes card(s) from the deck' do
            deck.take_card(2)
            expect(deck.cards.length).to be(50)
        end

        it 'takes and returns cards from the top' do
            top_card = deck.cards[0]
            expect(deck.take_card(1)[0]).to be(top_card)
        end

        it "won't let you take more cards than are available" do
            expect{deck.take_card(53)}.to raise_error("Can't take that many cards!")
        end
    end

    describe '#return_cards' do
        let(:some_cards) { deck.take_card(2) }
        it "return cards back to the deck" do
            deck.return_cards(some_cards)
            expect(deck.cards.length).to be(52)
        end

        it 'should add cards to the bottom of the deck' do
            deck.return_cards(some_cards)
            expect(deck.cards[50..52]).to eq(some_cards)
        end
    end
end