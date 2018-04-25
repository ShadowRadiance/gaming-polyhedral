module Polyhedral
  class Die
    include Comparable
    def <=>(other)
      return nil unless other.respond_to? :face
      face <=> other.face
    end

    attr_reader :sides, :face

    def initialize(sides = 6)
      raise 'Sides must be positive' unless sides.positive?
      @sides = sides
      @face = sides
    end

    def roll
      @face = Random.rand(1..sides)
      self
    end

    class << self
      def d4
        Die.new(4)
      end

      def d6
        Die.new(6)
      end

      def d8
        Die.new(8)
      end

      def d10
        Die.new(10)
      end

      def d12
        Die.new(12)
      end

      def d20
        Die.new(20)
      end

      def d100
        Die.new(100)
      end
    end
  end
end
