# frozen_string_literal: true

require 'spec_helper'
require 'polyhedral/die_histogram'

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

        it "has #{sides} sides" do
          expect(die.sides).to eq(sides)
        end

        it "generates numbers between 1 and #{sides}" do
          expect(die.roll.face).to be_between(1, sides)
        end

        it 'is a fair die' do
          h = DieHistogram.new(die: die, rolls: 100_000)
          (1..sides).each do
            expect(h).to be_fair
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
