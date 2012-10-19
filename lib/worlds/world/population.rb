module Worlds
  module Population
    DEFAULT_SAMPLE_SIZE = 30
    LARGE_SAMPLE_SIZE = 300000

    STRONG_CORRELATION = 0.8
    WEAK_CORRELATION = 0.5

    # default error tolerance
    # if a straight evaluation fails, we will in certain cases make
    # a percent error calculation to see if we were within 2% of desired target
    DEFAULT_TOLERANCE = 0.02

    class Base
      attr_accessor :categorical_features, :normally_distributed_features, :covariance_matrix

      def initialize
        #puts "--- Population intialized."
        @categorical_features = []
        @normally_distributed_features = []
      end

      def sample!(n=DEFAULT_SAMPLE_SIZE)
        #puts "--- Taking sample of size #{n}."
        Array.new(n) do
          #puts "--- Generating member #{n}..."
          member = features.inject({}) do |result, feature|
            #puts "--- Sampling feature #{feature.name}..."
            feature.sample!(result)
            result
          end
          #puts "--- Generated member: "
          #p member
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
          #member.merge(m) == m
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

      def percent_within_deviations?(feature_name, percentage=0.68, deviations=1, tolerance=DEFAULT_TOLERANCE)
        puts "--- Attempting to determine whether #{percentage}% of #{feature_name} is within #{deviations} standard deviations."
        feature = get_feature_by_name(feature_name)

        mean = feature.mean.to_f
        max_variance = (feature.standard_deviation.to_f * deviations).to_f
        puts "--- Maximum variance for this deviation: #{max_variance}"
        puts "--- Desired mean for this distribution: #{mean}"

        expected_percentage = percentage.to_f/100
        matched = sample.select do |s|
          (s[feature.name].to_f - mean).abs < max_variance
        end
        actual_percentage = (matched.count.to_f/sample.size) #*100
        puts "--- Matched percentage: #{actual_percentage*100}% (expected: #{expected_percentage*100}%)"
        puts "--- At least #{expected_percentage*100}% within deviation? #{actual_percentage >= expected_percentage}"

        return true if actual_percentage >= expected_percentage
        error = (expected_percentage - actual_percentage)/actual_percentage
        puts "--- Percentage error? #{error} (tolerance: #{tolerance})"
        error <= tolerance
      end

      def three_sigma_holds_for?(feature_name)
        puts "--- Attempting to determine whether the empirical rule holds for the sample population's #{feature_name}..."

        one_sigma = percent_within_deviations?(feature_name, 68, 1)
        two_sigma = percent_within_deviations?(feature_name, 95, 2) #.should be_true
        three_sigma = percent_within_deviations?(feature_name, 99.7, 3) #.should be_true

        puts "--- One sigma? #{one_sigma}"
        puts "--- Two sigma? #{two_sigma}"
        puts "--- Three sigma? #{three_sigma}"

        one_sigma and two_sigma and three_sigma
      end

      def three_sigma_holds?
        puts "--- Attempting to determine whether the empirical rule holds for the sample population..."
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
        puts "====="
        puts "--- Attempting to determine whether #{a} and #{b} are #{expected_rho*100}% correlated"
        x,y = sample.map { |s| s[a] }, sample.map { |s| s[b] }
        actual_rho = Pearson.score(x,y)
        puts "--- Actual correlation: #{actual_rho}"
        error = ((expected_rho-actual_rho)/actual_rho)
        puts "--- Percent error: #{error}"
        error < tolerance
      end

      def weakly_correlated?(a,b,tolerance=DEFAULT_TOLERANCE)
        correlated?(a,b,WEAK_CORRELATION,tolerance)
      end

      def strongly_correlated?(a,b,tolerance=DEFAULT_TOLERANCE)
        correlated?(a,b,STRONG_CORRELATION,tolerance)
      end
    end
  end
end