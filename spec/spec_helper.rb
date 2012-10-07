require 'rubygems'
require 'rspec'

require 'worlds'
include Worlds

require 'features/step_definitions/base_steps'
require 'features/step_definitions/population_steps'

RSpec.configure do |config|
  config.include BaseSteps
  config.include PopulationSteps
end