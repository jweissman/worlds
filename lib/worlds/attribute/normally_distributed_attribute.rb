module Worlds
  module Attribute
    class NormallyDistributedAttribute < Base
      attr_accessor :mean, :variance, :standard_deviation
      def initialize(name, mean=0, standard_deviation=1)
        super(name)
        @mean                = mean
        @standard_deviation  = standard_deviation
        @variance            = @standard_deviation**2
        @random_gaussian     = Helpers::RandomGaussian.new(@mean, @standard_deviation)
      end

      def sample
        @random_gaussian.rand
      end
    end
  end
end