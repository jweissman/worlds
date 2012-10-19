#module StepHelpers
def get_feature_by_name(feature_name)
  @normally_distributed_features.select { |f| f.name == feature_name }.first
end

def confirm_mean(feature, value, tolerance=get_feature_by_name(feature).standard_deviation/2)
  data = @sample.map { |s| s[feature].to_f }
  mean = data.inject(:+) / data.size.to_f
  (value.to_f - mean).abs.should <= tolerance.to_f
end

def percent_within_deviations?(feature, percentage=68, deviations=1)


  max_variance = (feature.standard_deviation.to_f * deviations).to_f
  expected_percentage = percentage.to_f/100

  puts "--- attempting to determine whether #{percentage}% (#{expected_percentage}) "
  puts "    of #{feature.name} is within #{deviations} deviation(s) (#{max_variance}) of mean"

  mean = feature.mean.to_f
  matched = @sample.select do |s|
    #puts "--- considering sample: #{s}"
    #(feature.mean.to_f - s[feature.name].to_f).abs > tolerance.to_f
    (s[feature.name].to_f - mean).abs < max_variance #.to_f
  end
  matched_percentage = matched.count.to_f/@sample.size
  puts "--- found #{matched_percentage*100}% of population with #{feature.name} within"
  puts "    #{max_variance} of #{feature.mean}.."

  # return true if >= expected percentage - 3%
  #tolerance = 0.03
  #(matched_percentage - expected_percentage).abs <= tolerance #.to_f/100
  matched_percentage >= expected_percentage
end

def confirm_three_sigma_for(feature)
  percent_within_deviations?(feature, 68, 1).should be_true
  percent_within_deviations?(feature, 95, 2).should be_true
  percent_within_deviations?(feature, 99.7, 3).should be_true
end

def confirm_three_sigma
  @normally_distributed_features.each do |feature|
    confirm_three_sigma_for(feature)
  end
  #@features.each do |feature|
  #  if feature.is_a? CorrelatedAttributeVector
  #    # need to check each feature
  #  elsif feature.is_a? NormallyDistributedAttribute
  #    confirm_three_sigma_for feature
  #  end
  #end
end

def correlate(a,b,rho)
  @covariance_matrix ||= Matrix.I(@normally_distributed_features.size)
  names = @normally_distributed_features.map(&:name)
  @covariance_matrix[names.index(a),names.index(b)] = rho
  @covariance_matrix[names.index(b),names.index(a)] = rho
end

def confirm_correlation(a,b,rho,tolerance=0.02)
  x,y = @sample.map { |s| s[a] }, @sample.map { |s| s[b] }
  (rho - Pearson.score(x,y)).abs.should < tolerance
end

def generate_sample(size=3)
  @features ||= []
  unless @normally_distributed_features.nil?
    if @normally_distributed_features.size <= 1
      @normally_distributed_features.each do |feature|
        @features << feature
      end
    else
      @features << CorrelatedAttributeVector.new(@normally_distributed_features, @covariance_matrix)
    end
  end
  @population = Worlds::Population::Base.new(@features)
  @sample = @population.sample(size)
end

def generate_large_sample; generate_sample(30) end
#end