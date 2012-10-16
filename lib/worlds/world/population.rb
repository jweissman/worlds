module Worlds
  module Population
    #
    #
    #
    #class Subpopulation < Struct.new(:constants, :attributes)
    #
    #end

    class Base < Struct.new(:attributes)
      def sample(n=30)
        Array.new(n) do
          self.attributes.inject({}) do |result, attr|
            attr.sample!(result)
            result
          end
        end
      end
    end

    #class CompositePopulation < Base
    #  def initialize(subpopulations) #, attributes)
    #    #super(attributes)
    #    @subpopulations = subpopulations
    #  end
    #
    #  def sample(n=30)
    #    @subpopulations.inject([]) do |result, subpop|
    #      result << subpop.sample(n/@subpopulations.count)
    #    end
    #  end
    #
    #end

  end
end