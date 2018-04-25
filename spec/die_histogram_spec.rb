require 'spec_helper'
require 'polyhedral/die_histogram'

module Polyhedral
  RSpec.describe DieHistogram do
    let(:die) do
      double('Die').tap do |dbl|
        allow(dbl).to receive(:sides).and_return(10)
        allow(dbl).to receive(:roll).and_return(dbl)
      end
    end

    context 'with a fair die' do
      let(:fair) do
        die.tap do |dbl|
          allow(dbl).to receive(:face).and_return(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
        end
      end
      subject { DieHistogram.new(die: fair, rolls: 10, tolerance: 0) }
      it { is_expected.to be_fair }
    end

    context 'with a loaded die' do
      let(:loaded) do
        die.tap do |dbl|
          allow(dbl).to receive(:face).and_return(10)
        end
      end
      subject { DieHistogram.new(die: loaded, rolls: 10, tolerance: 0) }
      it { is_expected.not_to be_fair }
    end
  end
end
