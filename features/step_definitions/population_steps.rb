$:.unshift File.dirname("..")

require 'lib/worlds'

include Worlds
include Worlds::Attribute

Before do
  @population = Population::Base.new
end

Given /^a feature "([^"]*)" with the constant value "([^"]*)"$/ do |name, value|
  @population.categorical_features << ConstantAttribute.new(name, value)
end

Given /^a feature "(.*?)" with the following values:/ do |name, table|
  @population.categorical_features << CategoricalAttribute.new(name, table.raw.flatten)
end

Given /^a feature "(.*?)" with mean (\d+) and standard deviation (\d+)$/ do |name, mean, std_dev|
  @population.normally_distributed_features << NormallyDistributedAttribute.new(name, mean.to_f, std_dev.to_f)
end

Given /^"(.*?)" and "(.*?)" are strongly correlated/ do |feature_one, feature_two|
  @population.strongly_correlate!(feature_one, feature_two)
end

Given /^"(.*?)" and "(.*?)" are weakly correlated/ do |feature_one, feature_two|
  @population.weakly_correlate!(feature_one, feature_two)
end

Given /"(.*?)" and "(.*?)" are (\d+)% correlated/ do |feature_one, feature_two, rho|
  @population.correlate!(feature_one, feature_two, rho.to_f/100)
end

When "the population is sampled" do
  @population.sample
end

When "a large population is sampled" do
  @population.large_sample
end

When /^a population of (\d+) is sampled/ do |population_size|
  @population.sample(population_size.to_i)
end

Then "I should see the following individuals:" do |table|
  table.hashes.all? { |h| @population.has_member?(h) }.should be_true
end

#Then "I should see individuals with "[^\"]*" ':feature_value'" do |feature, feature_value|
#  @sample.any? { |member| member[feature] == feature_value }.should be_true
#end

Then /^mean sample "(.*?)" should be within (\d+) of (\d+)/ do |feature, tolerance, value|
  @population.mean_within_tolerance_of_value(feature, value, tolerance).should be_true
end

#Then "mean sample :feature should be :value" do |feature, value|
#  confirm_mean(feature, value)
#end

#Then /^at least (\d+)% of sampled "(.*?)" should be within (\d+) deviations of mean/ do |expected_percentage, feature_name, tolerance|
#  @population.percent_within_deviations?(feature_name, percentage, tolerance).should be_true
#end

Then "the empirical rule should hold" do
  @population.three_sigma_holds?.should be_true
end

Then /^"(.*?)" and "(.*?)" should be weakly correlated/ do |feature_one, feature_two|
  @population.weakly_correlated?(feature_one, feature_two).should be_true
end

Then /"(.*?)" and "(.*?)" should be strongly correlated/ do |feature_one, feature_two|
  @population.strongly_correlated?(feature_one, feature_two).should be_true
end

Then /"(.*?)" and "(.*?)" should be (\d+)% correlated/ do |feature_one, feature_two, rho|
  @population.correlated?(feature_one, feature_two, rho.to_f/100).should be_true
end
