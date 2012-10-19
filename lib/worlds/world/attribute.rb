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
    class CorrelatedAttributeVector # < Struct.new(:features, :covariance_matrix)

      def initialize(features, covariance_matrix=Matrix.I(features.count))
        @features = features
        @covariance_matrix = covariance_matrix

        #puts "--- Initialized correlated attribute vector with features: "
        p @features
        #puts "--- Using covariance matrix: "
        p @covariance_matrix
      end

      def standard_normal
        @standard_normal ||= RandomGaussian.new(0,1)
      end

      def cholesky_decomposition
        @cholesky_decomposition ||= Cholesky.decomposition(@covariance_matrix)
      end

      def sample
        #puts "--- Attempting to sample correlated attributes..."
        normals = Array.new(@features.count) { standard_normal.rand }
        feature_vector = Matrix[normals]

        #puts "--- Standard normal feature vector: "
        #p feature_vector

        #puts "--- Attempting to multiply by cholesky decomposition of covariance matrix: "
        #p cholesky_decomposition

        correlated_feature_vector = feature_vector * cholesky_decomposition.t
        #puts "--- Correlated feature vector: "
        #p correlated_feature_vector


        resultant_feature_vector = []

        #p correlated_feature_vector
        correlated_feature_vector.each_with_index do |feature_value, _, index|
          feature = @features[index]
          #puts "--- Transforming feature #{index} (#{feature.name}); original value: #{feature_value}"
          value = (feature_value * feature.standard_deviation) + feature.mean
          #puts "--- After normalization (std dev #{feature.standard_deviation}, mean #{feature.mean}): #{value}"
          resultant_feature_vector << value
          #n+=1
        end

        #puts "--- Resultant feature vector: "
        #p resultant_feature_vector

        resultant_feature_vector
      end

      def sample!(individual)
        sample.each_with_index do |feature_value, index|
          individual[@features[index].name] = feature_value
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