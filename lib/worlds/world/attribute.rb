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

      def initialize(name, mean=0, standard_deviation=1)
        super(name)
        @mean = mean
        @standard_deviation = standard_deviation
        @random_gaussian = RandomGaussian.new(@mean, @standard_deviation)
      end

      def sample
        @random_gaussian.rand
      end
    end


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
        feature_vector = Array.new(features.length) { random_gaussian.rand }
        correlated_feature_vector = Matrix[feature_vector] * cholesky_decomposition.t

        resultant_feature_vector = []
        correlated_feature_vector.each_with_index do |feature_value, index|
          resultant_feature_vector << feature_value * features[index].mean
        end

        resultant_feature_vector
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