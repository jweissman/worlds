require 'rubygems'
require 'rspec'
require 'turnip'

require 'worlds'
include Worlds

require 'features/support/step_helpers'
require 'features/step_definitions/base_steps'
require 'features/step_definitions/population_steps'

RSpec.configure do |config|
  config.include StepHelpers
  config.include BaseSteps
  config.include PopulationSteps
end