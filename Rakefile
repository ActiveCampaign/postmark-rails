require 'bundler'
Bundler::GemHelper.install_tasks
require 'rake'

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/*_spec.rb'
  spec.rspec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
end


task :default => :spec

require 'rdoc/task'
desc 'Generate documentation'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = "postmark #{Postmark::Rails::VERSION}"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/postmark-rails.rb')
  rdoc.rdoc_files.include('lib/postmark-rails/**/*.rb')
end
