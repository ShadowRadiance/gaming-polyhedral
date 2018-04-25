module Polyhedral
  class Dice
    include Enumerable
    def each
      @dice.each { |d| yield d }
    end

    def initialize(dice_array = [])
      raise 'Pass an array' unless dice_array.respond_to?(:all?)
      raise 'Pass an array of dice' unless dice_array.all? do |die|
        die.is_a? Die
      end
      @dice = dice_array
    end

    def roll
      @dice.each(&:roll)
      self
    end

    def reroll_ones
      @dice.each { |die| die.roll if die.face == 1 }
      self
    end

    def drop_lowest(n_times = 1)
      @dice = @dice.sort.drop(n_times)
      self
    end

    def values
      @dice.map(&:face)
    end

    def sum
      @dice.map(&:face).sum
    end
  end
end
