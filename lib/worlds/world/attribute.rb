module Worlds
  module Attribute
    #
    #   Attribute base entity.
    #
    #   Subclasses expected to implement a #sample method, and override #sample!
    #
    class Base < Struct.new(:name)
      def sample!(individual)
        individual[name] = self.sample
      end
    end

    class ConstantAttribute < Base
      attr_accessor :value

      def initialize(name, value)
        super(name)
        @value = value
      end

      def sample
        @value
      end
    end

    class CategoricalAttribute < Base
      attr_accessor :values

      def initialize(name, values)
        super(name)
        @values = values
      end

      def sample
        @values.sample
      end
    end

    class NormallyDistributedAttribute < Base
      attr_accessor :mean, :standard_deviation

      def initialize(name, mean, standard_deviation)
        super(name)
        @mean = mean
        @standard_deviation = standard_deviation
        @random_gaussian = RandomGaussian.new(@mean, @standard_deviation)
      end

      def sample
        @random_gaussian.rand
      end
    end

    #class AttributePair < Base
    #  attr_accessor :feature_one, :feature_two
    #  def initialize(feature_one, feature_two)
    #    @feature_one = feature_one
    #    @feature_two = feature_two
    #  end
    #
    #  def sample
    #    [@feature_one.sample, @feature_two.sample]
    #  end
    #
    #  def sample!(individual)
    #    individual[@feature_one.name], individual[@feature_two.name] = sample
    #  end
    #end

    #
    #  We assume the two provided attributes are normally distributed.
    #  For standard normals, we make two draws Z1 and Z2 from the standard normal generator.
    #  Then, we use Z1 and Z3 = rho Z1 + Sqrt ( 1 - rho^2 ) Z2, where rho is the desired correlation.
    #
    #  N.B.: this approach is really not generalizable either in structure or logic to larger sets
    #  of correlated random variables. We'd need more sophisticated techniques (covariance matrices)
    #  to effectively achieve this...
    #
    #class CorrelatedAttributePair < AttributePair # Base #Struct.new(:feature_one, :feature_two, :rho)
    #  attr_accessor :rho
    #
    #  def initialize(feature_one, feature_two, rho)
    #    super(feature_one, feature_two)
    #    @rho = rho
    #    @rho_coeff = Math.sqrt(1-(@rho**2))
    #  end
    #
    #  def sample
    #    x,y = @feature_one.sample, @feature_two.sample
    #    y_prime = x*@rho + y*@rho #Math.sqrt(1-(@rho**2))
    #    [x, y_prime]
    #  end
    #end


    #
    #   Use a covariance matrix to generate random correlated multivariate values.
    #
    #   Assumptions:
    #     - features are normally distributed.
    #
    class CorrelatedAttributeVector < Struct.new(:features, :covariance_matrix)
      def random_gaussian
        @random_gaussian ||= RandomGaussian.new(0,1)
      end

      def cholesky_decomposition
        @cholesky_decomposition ||= Cholesky.decomposition(covariance_matrix)
      end

      def sample
        #puts "--- attempting to sample correlated attribute vector!"
        #p self

        feature_vector = Array.new(features.length) { random_gaussian.rand }
        correlated_feature_vector = cholesky_decomposition * Vector[*feature_vector]
        resultant_feature_vector = []
        correlated_feature_vector.each_with_index do |feature_value, index|
          resultant_feature_vector << feature_value * features[index].mean
        end

        return resultant_feature_vector
      end

      def sample!(individual)
        sample.each_with_index do |feature_value, index|
          individual[features[index].name] = feature_value
        end
      end
    end


    # ?
    #class AttributeVector < Base
    #  attr_accessor :feature_set
    #  def initialize(feature_set)
    #    @feature_set = feature_set
    #  end
    #
    #  def sample
    #    @feature_set.map(&:sample)
    #  end
    #end
    #
    #class CorrelatedAttributeVector < AttributeVector
    #  attr_accessor :covariance_matrix
    #  def initialize(feature_set, covariance_matrix)
    #    super(feature_set)
    #    @covariance_matrix = covariance_matrix
    #  end
    #
    #  def sample
    #
    #  end
    #end


  end
end