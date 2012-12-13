require "bundler/gem_tasks"
require "rspec/core/rake_task"

require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty -x"
  t.fork = false
end

RSpec::Core::RakeTask.new do |t| 
  t.rspec_opts = ["--color"]
end

task :default => [ :spec, :features ]
task :test => :spec


# namespace :spec do
#   desc "Run specs with RCov" 
#   RSpec::Core::RakeTask.new('simplecov') do |t|
#     t.pattern = 'spec/**/*_spec.rb'
#     t.simplecov = true
#     t.simplecov_opts = ['--exclude', '\\/Library\\/Ruby']
#   end 
# end
