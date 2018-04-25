require 'spec_helper'

module Polyhedral
  RSpec.describe Die do
    describe '#new' do
      context 'with zero sides' do
        it 'raises a RuntimeError' do
          expect { Die.new(0) }.to raise_error(RuntimeError)
        end
      end
      context 'with negative sides' do
        it 'raises a RuntimeError' do
          expect { Die.new(-2) }.to raise_error(RuntimeError)
        end
      end
      context 'with positive sides' do
        it 'does not raise a RuntimeError' do
          expect { Die.new(8) }.not_to raise_error
        end
      end
    end

    [4, 6, 8, 10, 12, 20, 100].each do |sides|
      context "with a d#{sides}" do
        let(:die) { Die.new(sides) }
        let(:another_die) { Die.new(sides) }
        let(:number_of_test_rolls) { 100000 }
        let(:histogram) do
          Hash.new(0).tap do |hist|
            number_of_test_rolls.times do
              hist[die.roll.face] += 1
            end
          end
        end
        let(:expected_face_count) { number_of_test_rolls/sides.to_f }
        let(:allowed_error) { number_of_test_rolls/100.0 }
        
        it "has #{sides} sides" do
          expect(die.sides).to eq(sides)
        end

        it "generates numbers between 1 and #{sides}" do
          expect(die.roll.face).to be_between(1, sides)
        end

        it 'is a fair die' do
          # puts histogram
          (1..sides).each do |n|
            expect(histogram[n]).to be_within(allowed_error).of(expected_face_count)
          end
        end
      end
    end

    describe '<=>' do
      let(:die) { Die.new }
      let(:another_die) { Die.new }
      before(:each) do
        die.roll
        another_die.roll
      end
      it 'can be compared to another die' do
        expect(die <=> another_die).to be_integer
      end
    end

    [4, 6, 8, 10, 12, 20, 100].each do |sides|
      describe "#d#{sides}" do
        subject { Die.send("d#{sides}".to_sym) }
        it "creates a d#{sides}" do
          expect(subject.sides).to be(sides)
        end
      end
    end
  end
end
