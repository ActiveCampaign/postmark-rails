$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'ruby-debug'
require 'actionmailer'
require 'postmark-rails'
require 'spec'
require 'spec/autorun'

ActionMailer::Base.delivery_method = :postmark
ActionMailer::Base.template_root = File.join(File.dirname(__FILE__), "fixtures", "views")

# require models
Dir["#{File.dirname(__FILE__)}/fixtures/models/*.rb"].each { |f| require f }

Spec::Runner.configure do |config|
  
end
