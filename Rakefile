require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:turnip) do |t|
  t.rspec_opts = ["-r turnip/rspec"]
  t.pattern = "spec/features/**/*.feature"
end

task :default => :turnip