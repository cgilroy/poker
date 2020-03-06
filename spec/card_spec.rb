require 'rspec'
require 'card'

describe Card do

    describe '#initialize' do
        subject(:card) { Card.new(:diamond, :five) }
        it 'assigns a suit and value' do
            expect(card.suit).to equal(:diamond)
            expect(card.value).to equal(:five)
        end

        it 'does not allow invalid suits' do
            expect { Card.new(:pickles,:three) }.to raise_error
        end

        it 'does not allow invalid values' do
            expect { Card.new(:diamond,:pickles) }.to raise_error
        end

    end

    describe '#==' do
        subject(:card) { Card.new(:spade, :six) }
        let(:same_card) { Card.new(:spade, :six) }
        let(:diff_card) { Card.new(:heart, :king) }
        it 'returns true when cards are identical' do
            expect(card == same_card).to be(true)
            expect(card == diff_card).to be(false)
        end
    end

end 