module Worlds
  module Attribute
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