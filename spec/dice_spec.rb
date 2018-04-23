require "spec_helper"

module Polyhedral
  RSpec.describe Dice do
    
    describe '#new' do
      context 'with zero dice' do
        it 'does not raise a RuntimeError' do
          expect { Dice.new([]) }.not_to raise_error
        end
      end
      context 'with an array of dice' do
        it 'does not raise a RuntimeError' do
          expect { Dice.new([Die.d6, Die.d6]) }.not_to raise_error
        end
      end
      context 'with things that are not dice' do
        it 'raises a RuntimeError' do
          expect { Dice.new("wat") }.to raise_error(RuntimeError)
          expect { Dice.new(["double", "wat"])}.to raise_error(RuntimeError)
        end
      end
    end
    
    it { is_expected.to be_a(Enumerable) }

    context 'with a set of four six-sided dice' do
      describe '#roll' do
        let(:die) do 
          double("Die").tap do |dbl|
            allow(dbl).to receive(:is_a?).with(Class) { true }
          end
        end
        subject { Dice.new([die, die, die, die]) }
        it 'rolls all the dice' do
          expect(die).to receive(:roll).exactly(4).times
          subject.roll
        end
      end
    end
    
    context "with five specific dice rolls (3,2,1,4,1)" do
      def die_with_face(n)
        Die.new(6).tap do |dbl|
          allow(dbl).to receive(:face).and_return(n)
        end
      end
      
      let(:die_with_face_1) { die_with_face(1) }
      let(:die_with_face_2) { die_with_face(2) }
      let(:die_with_face_3) { die_with_face(3) }
      let(:die_with_face_4) { die_with_face(4) }
      subject do
        Dice.new([
          die_with_face_3,
          die_with_face_2, 
          die_with_face_1,
          die_with_face_4,
          die_with_face_1 
        ])
      end

      describe '#reroll_ones' do
        it 'rerolls ones and only ones' do
          subject.roll
          expect(die_with_face_1).to receive(:roll).twice
          subject.reroll_ones
        end
      end
          
      describe '#values' do
        it 'retrieves the face values of the dice' do
          expect(subject.values).to match_array [4,3,2,1,1]
        end
      end
      
      describe '#sum' do
        it 'adds up the face values of the dice' do
          expect(subject.sum).to eq(11)
        end
      end
    
      describe '#drop_lowest' do
        it 'drops a die roll' do
          expect {
            subject.roll.drop_lowest
          }.to change {
            subject.values.size
          }.by(-1)
        end
        
        it 'drops the lowest die roll' do
          expect(subject.values).to match_array [4,3,2,1,1]
          subject.roll.drop_lowest
          expect(subject.values).to match_array [4,3,2,1]
        end
      end
    end
    
    context 'roll 4d6 drop lowest' do
      it 'rolls four dice and drops the lowest result' do
        dice = Dice.new [ Die.d6,Die.d6,Die.d6,Die.d6 ]
        dice.roll
        values1 = dice.values
        dice.drop_lowest
        values2 = dice.values
        sum = dice.sum
        
        expect(values2.size).to eq(values1.size - 1)
        expect(sum).to eq(values2.sum)
        # puts({ values1: values1, values2: values2, sum: sum }).to_s
      end
    end
    
  end
end
