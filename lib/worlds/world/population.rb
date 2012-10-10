module Worlds
  module World
    class CategoricalAttribute < Struct.new(:name, :values)
      def sample; self.values.sample end
      def sample!(individual)
        individual[name] = sample
      end
    end

    class NormallyDistributedAttribute < Struct.new(:name, :mean, :std_dev)
      attr_accessor :gaussian
      def normal_distribution
        self.gaussian ||= RandomGaussian.new(mean, std_dev)
      end

      def sample; self.normal_distribution.rand end
      def sample!(individual)
        individual[name] = sample # self.normal_distribution.rand
      end
    end

    #
    #  We assume the two provided attributes are normally distributed.
    #
    #  For standard normals, we make two draws Z1 and Z2 from the standard normal generator.
    #  Then, we use Z1 and Z3 = rho Z1 + Sqrt ( 1 - rho^2 ) Z2, where rho is the desired correlation.
    #
    class CorrelatedAttributes < Struct.new(:feature_one, :feature_two, :correlation)
      def sample!(individual)
        z1, z2 = self.feature_one.sample, self.feature_two.sample
        individual[feature_one.name] = z1
        rho = correlation
        z3 = rho*z1 + Math.sqrt(1-(rho**2))*z2
        individual[feature_two.name] = z3
      end
    end

    class Population < Struct.new(:attributes)
      def sample(n=30)
        Array.new(n) do
          self.attributes.inject({}) do |result, attr|
            attr.sample!(result)
            result
          end
        end
      end
    end
  end
end