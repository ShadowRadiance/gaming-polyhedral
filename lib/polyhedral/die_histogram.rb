# frozen_string_literal: true

module Polyhedral
  class DieHistogram
    attr_reader :die, :rolls, :tolerance

    def initialize(die:, rolls:, tolerance: nil)
      @die = die
      @rolls = rolls
      @tolerance = tolerance || (rolls / 100.0)
    end

    def histogram
      @histogram ||= regenerate_histogram
    end

    def fair?(within: nil)
      range = 1..(die.sides)
      range.all? { |side| side_fair?(side, within) }
    end

    private

    def side_fair?(side, within)
      within ||= @tolerance
      (histogram[side] - expected_count_per_face).abs <= within
    end

    def expected_count_per_face
      rolls / die.sides.to_f
    end

    def regenerate_histogram
      Hash.new(0).tap do |hist|
        rolls.times { hist[die.roll.face] += 1 }
      end
    end
  end
end
