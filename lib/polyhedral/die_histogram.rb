# frozen_string_literal: true

module Polyhedral
  class DieHistogram
    attr_reader :die, :rolls, :tolerance

    def initialize(die:, rolls:, tolerance: nil, progress_marker: nil)
      @die = die
      @rolls = rolls
      @tolerance = tolerance || (rolls / 100.0)
      @progress_marker = progress_marker
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
      hist = Hash.new(0)
      marker_counter = rolls / 10
      rolls.times do |n|
        hist[die.roll.face] += 1
        print(@progress_marker) if @progress_marker && (n % marker_counter).zero?
      end
      hist
    end
  end
end
