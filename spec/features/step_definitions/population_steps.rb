require 'worlds/world/population'
require 'peach'

module PopulationSteps
  step "a feature ':name' with the following values:" do |name, values|
    #puts "--- creating feature #{name} with values: "
    #p values.raw.flatten
    @features ||= []
    @features << CategoricalAttribute.new(name, values.raw.flatten)
  end

  step "a feature ':name' with mean :mean and variance :variance" do |name, mean, variance|
    @features ||= []
    @features << NormallyDistributedAttribute.new(name, mean.to_f, variance.to_f)
  end

  # an evenly-distributed scalar
  #step "a feature ':name' between :min and :max" do |name, min, max|
  #  puts "--- creating feature #{name} between range #{min}..#{max}"
  #  puts
  #end
  #
  ## an independent gaussian scalar
  #step "a feature ':name' with average :avg and deviation :std_dev" do |name, avg, std_dev|
  #
  #end

  # how to capture dependent fields?
  ## (height/weight distro dependent on gender)
  # i think we need another level of abstraction -- i.e., subpopulations
  # step "the subpopulation :subpop has :name with the following values: "
  # step "the subpopulation :subpop has :name with mean :mean and variance :variance"

  step "the population is sampled" do
    @population = Population.new(@features)
    @sample = @population.sample
  end

  step "a population of :population_size is sampled" do |population_size|
    @population = Population.new(@features)
    @sample = @population.sample(population_size.to_i)
  end

  step "I should see the following individuals" do |table|
    table.hashes.each do |hash|
      @sample.any? { |member| member == hash }.should be_true
    end
  end

  # similar to above but with tolerance limits?
  # step "I should see individuals like the following"
end