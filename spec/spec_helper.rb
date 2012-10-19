require 'rubygems'
require 'bundler/setup'

require 'support/step_helpers'
require 'step_definitions/population_steps'

RSpec.configure do |config|
  config.include StepHelpers
  config.include PopulationSteps
end