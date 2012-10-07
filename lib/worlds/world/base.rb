module Worlds
  module World
    SIZES = {
        tiny:   [1,1],
        small:  [5,5],
        medium: [10, 10],
        big:    [20, 20]
    }

    DEFAULT_NAME = 'AnonymousWorld' #proc { DefaultNameGenerator.generate! }
    DEFAULT_SIZE = :medium

    #
    #   Base is a skeletal superclass from which more complicated worlds can be made.
    #
    class Base
      attr_accessor :name, :size, :width, :height, :cells, :history

      def initialize(opts={})
        self.name = opts.delete(:name) || DEFAULT_NAME #|| Worlds::Generators::NameGenerator.generate!
        self.size = opts.delete(:size) || DEFAULT_SIZE

        # go ahead and remember width/height
        (self.width,self.height) = SIZES[self.size]

        self.history = opts.delete(:history) || []
      end

      def awesome?; true end

      def generate!
        puts 'would be generating a world here, boss'
      end
    end
  end
end