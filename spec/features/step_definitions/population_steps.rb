require 'worlds/world/population'
require 'worlds/helpers/random_gaussian'
require 'worlds/helpers/pearson'
require 'peach'

module PopulationSteps
  step "a feature ':name' with the following values:" do |name, values|
    @features ||= {}
    @features[name] = CategoricalAttribute.new(name, values.raw.flatten)
  end

  step "a feature ':name' with mean :mean and standard deviation :std_dev" do |name, mean, std_dev|
    @features ||= {}
    @features[name] = NormallyDistributedAttribute.new(name, mean.to_f, std_dev.to_f)
  end

  step "features ':feature_one' and ':feature_two' have an :rho percent correlation" do |feature_one, feature_two, rho|
    one, two = @features.delete(feature_one), @features.delete(feature_two)
    @features["#{feature_one}+#{feature_two}"] = CorrelatedAttributes.new(one, two, rho.to_f/100)
  end

  step "the population is sampled" do
    @population = Population.new(@features.values)
    @sample = @population.sample
  end

  step "a population of :population_size is sampled" do |population_size|
    @population = Population.new(@features.values)
    @sample = @population.sample(population_size.to_i)
  end

  step "I should see the following individuals" do |table|
    table.hashes.each do |hash|
      @sample.any? { |member| member == hash }.should be_true
    end
  end

  step "average sampled :feature should be within :tolerance of :value" do |feature, tolerance, value|
    data = @sample.map { |s| s[feature] }
    mean = data.inject(:+).to_f / data.size
    (value.to_f - mean).abs.should <= tolerance.to_f
  end

  step ":percentage percent of sample :feature should be within :tolerance of :value" do |percentage, feature, tolerance, value|
    matched = @sample.select do |s|
      (value.to_f - s[feature].to_f).abs < tolerance.to_f
    end
    (matched.count/@sample.size).should <= percentage.to_f/100
  end

  step "sample :feature_one should have an :rho percent correlation to sample :feature_two" do |feature_one, rho, feature_two|
    x, y = @sample.map { |s| s[feature_one] }, @sample.map { |s| s[feature_two] }
    # default tolerance => +/- 0.2
    (rho.to_f/100 - Pearson.score(x,y)).should < 0.1
  end
end