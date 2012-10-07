module Worlds
  module World
    class CategoricalAttribute < Struct.new(:name, :values)
      def sample
        self.values.sample
      end
    end

    class NormallyDistributedAttribute < Struct.new(:name, :mean, :variance)
      def sample
        raise "Not implemented"
      end
    end

    #class VectorAttribute < Struct.new(:name, :attributes)
    #  def sample
    #    self.attributes.inject({}) do |result, attribute|
    #      result[attribute.name] = attribute.sample
    #    end
    #  end
    #end

    #
    # class DependentVectorAttribute < Struct.name(:name, :attributes, :rules)
    #

    class Population < Struct.new(:attributes)
      def sample(n=30)
        Array.new(n) do
          self.attributes.inject({}) do |result, attr|
            result[attr.name] = attr.sample
            result
          end
        end
      end
    end



  end
end