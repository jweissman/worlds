require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["-r turnip/rspec"]
  t.pattern = "spec/**/*.*"
end

task :default => :spec

