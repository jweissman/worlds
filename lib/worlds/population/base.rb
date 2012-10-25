module Worlds
  module Population
    class Base
      attr_accessor :categorical_features, :normally_distributed_features, :covariance_matrix
      def initialize
        @categorical_features = []
        @normally_distributed_features = []
      end

      def sample!(n=DEFAULT_SAMPLE_SIZE)
        Array.new(n) do
          member = features.inject({}) do |result, feature|
            feature.sample!(result)
            result
          end
          member
        end
      end

      def sample(n=DEFAULT_SAMPLE_SIZE)
        @sample ||= sample!(n)
      end

      def large_sample
        @sample ||= sample!(LARGE_SAMPLE_SIZE)
      end

      def aggregate_features!
        _features = @categorical_features
        unless @normally_distributed_features.nil?
          if @normally_distributed_features.size <= 1 or @covariance_matrix.nil?
            @normally_distributed_features.each do |feature|
              _features << feature
            end
          else
            _features << CorrelatedAttributeVector.new(@normally_distributed_features, @covariance_matrix)
          end
        end
        _features
      end

      def features
        @features ||= aggregate_features!
      end

      # some helpers
      def has_member?(member)
        sample.any? do |_member|
          member.keys.all? do |k|
            member[k] == _member[k]
          end
        end
      end

      def get_feature_by_name(feature_name)
        if @normally_distributed_features.map(&:name).include?(feature_name)
          @normally_distributed_features.select { |f| f.name == feature_name }.first
        else
          features.select { |f| f.name == feature_name }.first
        end
      end

      def mean_for_feature(feature_name)
        data = sample.map { |s| s[feature_name].to_f }
        data.sum / data.size.to_f
      end

      def mean_value?(feature_name, value, tolerance=DEFAULT_TOLERANCE) #get_feature_by_name(feature).standard_deviation/2)
        expected_mean = value.to_f
        actual_mean = mean_for_feature(feature_name)
        error = (expected_mean-actual_mean).to_f/actual_mean
        error.should <= tolerance.to_f
      end

      # TODO refactor -- very complex
      def percent_within_deviations?(feature_name, percentage=0.68, deviations=1, tolerance=DEFAULT_TOLERANCE)
        feature = get_feature_by_name(feature_name)
        mean = feature.mean.to_f
        max_variance = (feature.standard_deviation.to_f * deviations).to_f
        expected_percentage = percentage.to_f/100
        matched = sample.select do |s|
          (s[feature.name].to_f - mean).abs < max_variance
        end
        actual_percentage = (matched.count.to_f/sample.size) #*100
        return true if actual_percentage >= expected_percentage
        error = (expected_percentage - actual_percentage)/actual_percentage
        error <= tolerance
      end

      def three_sigma_holds_for?(feature_name)
        one_sigma = percent_within_deviations?(feature_name, 68, 1)
        two_sigma = percent_within_deviations?(feature_name, 95, 2)
        three_sigma = percent_within_deviations?(feature_name, 99.7, 3)
        one_sigma and two_sigma and three_sigma
      end

      def three_sigma_holds?
        @normally_distributed_features.all? do |feature|
          three_sigma_holds_for?(feature.name)
        end
      end

      def correlate!(a,b,rho)
        @covariance_matrix ||= Matrix.I(@normally_distributed_features.size)
        names = @normally_distributed_features.map(&:name)
        @covariance_matrix[names.index(a),names.index(b)] = rho
        @covariance_matrix[names.index(b),names.index(a)] = rho
      end

      def strongly_correlate!(a,b)
        correlate!(a,b,STRONG_CORRELATION)
      end

      def weakly_correlate!(a,b)
        correlate!(a,b,WEAK_CORRELATION)
      end

      def correlated?(a,b,expected_rho,tolerance=DEFAULT_TOLERANCE)
        x,y = sample.map { |s| s[a] }, sample.map { |s| s[b] }
        actual_rho = Pearson.score(x,y)
        error = ((expected_rho-actual_rho)/actual_rho)
        error < tolerance
      end

      def weakly_correlated?(a,b,tolerance=DEFAULT_TOLERANCE)
        correlated?(a,b,WEAK_CORRELATION,tolerance)
      end

      def strongly_correlated?(a,b,tolerance=DEFAULT_TOLERANCE)
        correlated?(a,b,STRONG_CORRELATION,tolerance)
      end

      def constant_feature(name, value)
        @categorical_features << ConstantAttribute.new(name, value)
      end

      def categorical_feature(name, values)
        @categorical_features << CategoricalAttribute.new(name, values)
      end

      def normally_distributed_feature(name, mean, std_dev)
        @normally_distributed_features << NormallyDistributedAttribute.new(name, mean, std_dev)
      end

      class << self
        def feature(name,opts={})
          if opts.include?(:mean) or opts.include?(:standard_deviation)
            unless opts.include?(:mean) and opts.include?(:standard_deviation)
              raise "Normally-distributed features must provide both :mean and :standard_deviation"
            end
            normally_distributed_feature(name, opts[:mean], opts[:standard_deviation])
          elsif opts.include?(:value)
            constant_feature(name, opts[:value])
          elsif opts.include?(:values)
            categorical_feature(name, opts[:values])
          end
        end

        def correlate(feature_one, feature_two, rho=STRONG_CORRELATION)
          correlate!(feature_one, feature_two, rho)
        end

        def correlate_strongly(feature_one, feature_two)
          strongly_correlate!(feature_one, feature_two)
        end

        def correlate_weakly(feature_one, feature_two)
          weakly_correlate!(feature_one, feature_two)
        end
      end
    end
  end
end