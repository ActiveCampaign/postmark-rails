require 'bundler'
Bundler::GemHelper.install_tasks
require 'rake'

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
end

task :default => :spec