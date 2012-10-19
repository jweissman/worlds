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

    # currently unused -- but for subpops...
    #class ConstantAttribute < Base
    #  attr_accessor :value
    #  def initialize(name, value)
    #    super(name)
    #    @value = value
    #  end
    #
    #  def sample
    #    @value
    #  end
    #end

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
      attr_accessor :mean, :variance, :standard_deviation
      def initialize(name, mean=0, standard_deviation=1)
        super(name)
        @mean                = mean
        @standard_deviation  = standard_deviation
        @variance            = @standard_deviation**2
        @random_gaussian     = RandomGaussian.new(@mean, @standard_deviation)
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
    class CorrelatedAttributeVector
      def initialize(features, covariance_matrix=Matrix.I(features.count))
        @features = features
        @covariance_matrix = covariance_matrix
      end

      def standard_normal
        @standard_normal ||= RandomGaussian.new(0,1)
      end

      def cholesky_decomposition
        @cholesky_decomposition ||= Cholesky.decomposition(@covariance_matrix)
      end

      def sample
        normals = Array.new(@features.count) { standard_normal.rand }
        feature_vector = Matrix[normals]
        correlated_feature_vector = feature_vector * cholesky_decomposition.t
        resultant_feature_vector = []
        correlated_feature_vector.each_with_index do |feature_value, _, index|
          feature = @features[index]
          value = (feature_value * feature.standard_deviation) + feature.mean
          resultant_feature_vector << value
        end
        resultant_feature_vector
      end

      def sample!(individual)
        sample.each_with_index do |feature_value, index|
          individual[@features[index].name] = feature_value
        end
      end
    end
  end
end