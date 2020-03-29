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

    describe 'rank' do
      it 'should correctly identify the hand rank' do
        hands.each_with_index do |hand, i|
          expect(hand.rank).to eq(hand_ranks[i])
        end
      end

      context 'when straight' do
        let(:ace_straight) do
          Hand.new([
            Card.new(:heart, :ace),
            Card.new(:spade, :two),
            Card.new(:heart, :three),
            Card.new(:heart, :four),
            Card.new(:heart, :five)
          ])
        end

        it 'should allow ace as the low card' do
          expect(ace_straight.rank).to eq(:straight)
        end
      end
    end

    describe '#<=>' do
      it 'returns 1 for a hand with a higher rank' do
        expect(royal_flush <=> straight_flush).to eq(1)
      end

      it 'returns -1 for a hand with a lower rank' do
        expect(straight_flush <=> royal_flush).to eq(-1)
      end

      it 'returns 0 for identical hands' do
        expect(straight_flush <=> straight_flush).to eq(0)
      end

      context 'when hands have the same rank (tie breaker)' do
        context 'when royal flush' do
          let(:heart_royal_flush) do
            Hand.new([
              Card.new(:heart, :ace),
              Card.new(:heart, :king),
              Card.new(:heart, :queen),
              Card.new(:heart, :jack),
              Card.new(:heart, :ten)
            ])
          end

          let(:spade_royal_flush) do
            Hand.new([
              Card.new(:spade, :ace),
              Card.new(:spade, :king),
              Card.new(:spade, :queen),
              Card.new(:spade, :jack),
              Card.new(:spade, :ten)
            ])
          end

          it 'compares based on suit' do
            expect(heart_royal_flush <=> spade_royal_flush).to eq(-1)
            expect(spade_royal_flush <=> heart_royal_flush).to eq(1)
          end
        end

        context 'straight flush' do
          let(:straight_flush_eight) do
            Hand.new([
              Card.new(:spade, :eight),
              Card.new(:spade, :seven),
              Card.new(:spade, :six),
              Card.new(:spade, :five),
              Card.new(:spade, :four)
            ])
          end

          let(:straight_flush_nine) do
            Hand.new([
              Card.new(:spade, :nine),
              Card.new(:spade, :eight),
              Card.new(:spade, :seven),
              Card.new(:spade, :six),
              Card.new(:spade, :five)
            ])
          end

          let(:heart_flush_nine) do
            Hand.new([
              Card.new(:heart, :nine),
              Card.new(:heart, :eight),
              Card.new(:heart, :seven),
              Card.new(:heart, :six),
              Card.new(:heart, :five)
            ])
          end

          it 'compares based on high card' do
            expect(straight_flush_nine <=> straight_flush_eight).to eq(1)
            expect(straight_flush_eight <=> straight_flush_nine).to eq(-1)
          end

          it 'compares based on suit when high card is the same' do
            expect(straight_flush_nine <=> heart_flush_nine).to eq(1)
            expect(heart_flush_nine <=> straight_flush_nine).to eq(-1)
          end
        end

        context 'when four of a kind' do
          let(:ace_four) do
            Hand.new([
              Card.new(:spade, :ace),
              Card.new(:heart, :ace),
              Card.new(:diamond, :ace),
              Card.new(:club, :ace),
              Card.new(:spade, :ten)
            ])
          end

          let(:king_four) do
            Hand.new([
              Card.new(:spade, :king),
              Card.new(:heart, :king),
              Card.new(:diamond, :king),
              Card.new(:club, :king),
              Card.new(:spade, :ten)
            ])
          end

          it 'compares based on four of a kind value' do
            expect(ace_four <=> king_four).to eq(1)
            expect(king_four <=> ace_four).to eq(-1)
          end

          let(:ace_with_two) do
            Hand.new([
              Card.new(:spade, :ace),
              Card.new(:heart, :ace),
              Card.new(:diamond, :ace),
              Card.new(:club, :ace),
              Card.new(:spade, :two)
            ])
          end

          it 'compares based on high card value if same four of a kind value' do
            expect(ace_four <=> ace_with_two).to eq(1)
            expect(ace_with_two <=> ace_four).to eq(-1)
          end

          let(:ace_with_two_heart) do
            Hand.new([
              Card.new(:spade, :ace),
              Card.new(:heart, :ace),
              Card.new(:diamond, :ace),
              Card.new(:club, :ace),
              Card.new(:heart, :two)
            ])
          end

          it 'compares based on high card suit if same high card value' do
            expect(ace_with_two <=> ace_with_two_heart).to eq(1)
            expect(ace_with_two_heart <=> ace_with_two).to eq(-1)
          end
        end

        context 'when two pair' do
          let(:two_pair_3_4) do
            Hand.new([
              Card.new(:spade, :three),
              Card.new(:heart, :three),
              Card.new(:heart, :four),
              Card.new(:diamond, :four),
              Card.new(:heart, :ten)
            ])
          end

          let(:two_pair_4_5) do
            Hand.new([
              Card.new(:spade, :five),
              Card.new(:heart, :five),
              Card.new(:heart, :four),
              Card.new(:diamond, :four),
              Card.new(:heart, :ten)
            ])
          end

          let(:pair_of_sixes) do
            Hand.new([
              Card.new(:spade, :six),
              Card.new(:heart, :six),
              Card.new(:heart, :four),
              Card.new(:diamond, :five),
              Card.new(:heart, :ten)
            ])
          end

          it 'two pair beats one pair' do
            expect(two_pair_4_5 <=> pair_of_sixes).to eq(1)
          end

          it 'higher of two pairs wins' do
            expect(two_pair_4_5 <=> two_pair_3_4).to eq(1)
          end

        end

        context 'when one pair' do
          let(:ace_pair) do
            Hand.new([
              Card.new(:spade, :ace),
              Card.new(:spade, :ace),
              Card.new(:heart, :queen),
              Card.new(:diamond, :jack),
              Card.new(:heart, :ten)
            ])
          end

          let(:king_pair) do
            Hand.new([
              Card.new(:spade, :king),
              Card.new(:spade, :king),
              Card.new(:heart, :queen),
              Card.new(:diamond, :jack),
              Card.new(:heart, :ten)
            ])
          end

          let(:three_pair_jack_high) do
            Hand.new([
              Card.new(:spade, :three),
              Card.new(:heart, :three),
              Card.new(:diamond, :nine),
              Card.new(:heart, :jack),
              Card.new(:heart, :ten)
            ])
          end

          let(:three_pair_king_high) do
            Hand.new([
              Card.new(:spade, :three),
              Card.new(:heart, :three),
              Card.new(:diamond, :nine),
              Card.new(:heart, :king),
              Card.new(:heart, :ten)
            ])
          end

          let(:four_pair) do
            Hand.new([
              Card.new(:spade, :four),
              Card.new(:heart, :four),
              Card.new(:diamond, :ace),
              Card.new(:heart, :two),
              Card.new(:heart, :three)
            ])
          end

          it 'should compare based on pair value' do
            expect(ace_pair <=> king_pair).to eq(1)
            expect(four_pair <=> three_pair_jack_high).to eq(1)
          end

          let(:ace_pair_king_high) do
            Hand.new([
              Card.new(:spade, :ace),
              Card.new(:spade, :ace),
              Card.new(:heart, :king),
              Card.new(:diamond, :jack),
              Card.new(:heart, :ten)
            ])
          end

          it 'should compare based on high card if same pair value' do
            expect(ace_pair_king_high <=> ace_pair).to eq(1)
            expect(three_pair_king_high <=> three_pair_jack_high).to eq(1)
          end
        end

        context 'when high card' do
          let(:ten_high) do
            Hand.new([
              Card.new(:spade, :two),
              Card.new(:heart, :four),
              Card.new(:diamond, :six),
              Card.new(:spade, :nine),
              Card.new(:spade, :ten)
            ])
          end

          let(:king_high) do
            Hand.new([
              Card.new(:spade, :two),
              Card.new(:heart, :four),
              Card.new(:diamond, :six),
              Card.new(:spade, :nine),
              Card.new(:spade, :king)
            ])
          end

          it 'should compare based on high card' do
            expect(king_high <=> ten_high).to eq(1)
            expect(ten_high <=> king_high).to eq(-1)
          end
        end
      end
    end

    describe '::winner' do
      it 'returns the winning hand' do
        high_hands = [flush, straight_flush, one_pair]
        expect(Hand.winner(high_hands)).to eq(straight_flush)

        low_hands = [one_pair, two_pair, three_of_a_kind]
        expect(Hand.winner(low_hands)).to eq(three_of_a_kind)
      end
    end

    end
end