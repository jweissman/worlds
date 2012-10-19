$:.unshift File.dirname("..")

require 'lib/worlds/world/attribute'
require 'lib/worlds/world/population'
require 'lib/worlds/ext/matrix'
require 'lib/worlds/helpers/random_gaussian'
require 'lib/worlds/helpers/pearson'
require 'lib/worlds/helpers/cholesky'

include Worlds::Attribute

Given /^a feature "[^\"]*" with the following values:/ do |name, values|
  @features ||= []
  @features << CategoricalAttribute.new(name, values.raw.flatten)
end

Given /^a feature "(.*?)" with mean (\d+) and standard deviation (\d+)$/ do |name, mean, std_dev|
  @normally_distributed_features ||= []
  @normally_distributed_features << NormallyDistributedAttribute.new(name, mean.to_f, std_dev.to_f)
end

Given /^"(.*?)" and "(.*?)" are strongly correlated/ do |feature_one, feature_two|
  correlate(feature_one, feature_two, 0.8)
end

Given /^"(.*?)" and "(.*?)" are weakly correlated/ do |feature_one, feature_two|
  correlate(feature_one, feature_two, 0.5)
end

Given /"(.*?)" and "(.*?)" are :rho percent correlated/ do |feature_one, feature_two, rho|
  correlate(feature_one, feature_two, rho.to_f/100)
end

When "the population is sampled" do
  generate_sample
end

When "a large population is sampled" do
  generate_large_sample
end

When /^a population of (\d+) is sampled/ do |population_size|
  generate_sample(population_size.to_i)
end

Then "I should see the following individuals:" do |table|
  table.hashes.each do |hash|
    @sample.any? { |member| member == hash }.should be_true
  end
end

#Then "I should see individuals with "[^\"]*" ':feature_value'" do |feature, feature_value|
#  @sample.any? { |member| member[feature] == feature_value }.should be_true
#end

Then /^mean sample "(.*?)" should be within (\d+) of (\d+)/ do |feature, tolerance, value|
  confirm_mean(feature, value, tolerance)
end

#Then "mean sample :feature should be :value" do |feature, value|
#  confirm_mean(feature, value)
#end

Then /^at least (\d+)% of sampled "(.*?)" should be within (\d+) deviations of mean/ do |expected_percentage, feature, tolerance|
  percent_within_deviations?(get_feature_by_name(feature), percentage, tolerance).should be_true
end

Then "the empirical rule should hold" do
  confirm_three_sigma
end

Then /^"(.*?)" and "(.*?)" should be weakly correlated/ do |feature_one, feature_two|
  confirm_correlation(feature_one, feature_two, 0.50)
end

Then /"(.*?)" and "(.*?)" should be strongly correlated/ do |feature_one, feature_two|
  confirm_correlation(feature_one, feature_two, 0.80)
end

Then /"(.*?)" and "(.*?)" should be (\d+)% correlated/ do |feature_one, feature_two, rho|
  confirm_correlation(feature_one, feature_two, rho.to_f/100)
end