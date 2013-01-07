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

namespace :engine do
  desc "Create a new codesake engine for the given programming language" 
  task :new, :name do |n, args|
    raise "You must provide a programming language in order to create an engine" if n.nil?

    name = n.downcase
    puts "Creating directories for #{name}"
    mkdir_p spec
    mkdir_p lib/codesake/engine
    mkdir_p lib/codesake/engine/name

    file = "lib/codesake/engine/#{name}"
    if File.exist?(file)
      abort("rake aborted!") if ask("#{file} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end

    open(file, "w") do |engine|
      engine.puts "require 'codesake/engine/core'"
      engine.puts "module Codesake"
      engine.puts " module Engine"
      engine.puts "   class #{name.capitalize}"
      engine.puts "     include Codesake::Utils::Files"
      engine.puts "     include Codesake::Utils::Secrets"
      engine.puts "     include Codesake::Engine::Core"
      engine.puts ""
      engine.puts "     def initialize(filename, options)"
      engine.puts "     end"
      engine.puts ""
      engine.puts "     def analyse"
      engine.puts "       # your code here"
      engine.puts "     end"
      engine.puts ""
      engine.puts "   end"
      engine.puts " end"
      engine.puts "end"
    end

    puts "#{file} created"

    open("lib/codesake.rb", "a") do |f|
      f.puts "require \"codesake/engine/#{name}\""
    end

    puts "lib/codesake.rb modified"


    file = "spec/#{name}_engine_spec.rb"
    if File.exist?(file)
      abort("rake aborted!") if ask("#{file} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end
    open(file, "w") do |spec|
      spec.puts "require 'spec_helper'"
      spec.puts ""
      spec.puts "describe Codesake::Engine::#{name.capitalize}"
      spec.puts " it \"tests must be written\""
      spec.puts "end"
    end
    puts "#{file} created"

    file = "features/codesake_process_#{name}_file.feature"
    open(file, "w") do |feature|
      feature.puts "# put your cucumber feature for #{name} here"
    end
    puts "#{file} created"

  end

end

# namespace :spec do
#   desc "Run specs with RCov" 
#   RSpec::Core::RakeTask.new('simplecov') do |t|
#     t.pattern = 'spec/**/*_spec.rb'
#     t.simplecov = true
#     t.simplecov_opts = ['--exclude', '\\/Library\\/Ruby']
#   end 
# end
