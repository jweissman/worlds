require 'worlds/world/attribute'
require 'worlds/world/population'
require 'worlds/helpers/random_gaussian'
require 'worlds/helpers/pearson'

include Worlds::Attribute
module PopulationSteps

  step "a feature :name with the following values:" do |name, values|
    @features ||= []
    @features << CategoricalAttribute.new(name, values.raw.flatten)
  end

  step "a feature :name with mean :mean and standard deviation :std_dev" do |name, mean, std_dev|
    @normally_distributed_features ||= []
    @normally_distributed_features << NormallyDistributedAttribute.new(name, mean.to_f, std_dev.to_f)
  end

  step "a feature :name with mean :mean" do |name, mean|
    @normally_distributed_features ||= []
    @normally_distributed_features << NormallyDistributedAttribute.new(name, mean.to_f)
  end

  step ":feature_one and :feature_two are strongly correlated" do |feature_one, feature_two|
    correlate(feature_one, feature_two, 0.8)
  end

  step ":feature_one and :feature_two are weakly correlated" do |feature_one, feature_two|
    correlate(feature_one, feature_two, 0.5)
  end

  step ":feature_one and :feature_two are :rho percent correlated" do |feature_one, feature_two, rho|
    correlate(feature_one, feature_two, rho.to_f/100)
  end

  step "the population is sampled" do
    generate_sample
  end

  step "a large population is sampled" do
    generate_sample(30000)
  end

  step "a population of :population_size is sampled" do |population_size|
    generate_sample(population_size.to_i)
  end

  step "I should see the following individuals" do |table|
    table.hashes.each do |hash|
      @sample.any? { |member| member == hash }.should be_true
    end
  end

  step "I should see individuals with :feature ':feature_value'" do |feature, feature_value|
    @sample.any? { |member| member[feature] == feature_value }.should be_true
  end

  step "mean :feature should be within :tolerance of :value" do |feature, tolerance, value|
    #data = @sample.map { |s| s[feature].to_f }
    #mean = data.inject(:+) / data.size.to_f
    #(value.to_f - mean).abs.should <= tolerance.to_f
    confirm_mean(feature, value, tolerance)
  end

  step "mean :feature should be :value" do |feature, value|
    #data = @sample.map { |s| s[feature].to_f }
    #mean = data.inject(:+) / data.size.to_f
    #(value.to_f - mean).abs.should <= tolerance.to_f
    confirm_mean(feature, value)
  end

  step "at least :percentage percent of sampled :feature should be within :tolerance of :value" do |percentage, feature, tolerance, value|
    matched = @sample.select do |s|
      (value.to_f - s[feature].to_f).abs < tolerance.to_f
    end
    (matched.count/@sample.size).should <= percentage.to_f/100
  end

  step ":feature_one and :feature_two should be weakly correlated" do |feature_one, feature_two|
    confirm_correlation(feature_one, feature_two, 0.50)
  end

  step ":feature_one and :feature_two should be strongly correlated" do |feature_one, feature_two|
    confirm_correlation(feature_one, feature_two, 0.80)
  end

  step ":feature_one and :feature_two should be :rho percent correlated" do |feature_one, feature_two, rho|
    confirm_correlation(feature_one, feature_two, rho.to_f/100)
  end
end