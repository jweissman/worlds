require 'rubygems'
require 'bundler/setup'
require "bundler/gem_tasks"

require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

task :test => [:features]
task :default => [:test]
