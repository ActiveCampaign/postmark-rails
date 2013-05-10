$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'postmark'
require 'postmark-rails'
require 'json'

ActionMailer::Base.delivery_method = :postmark
ActionMailer::Base.prepend_view_path(File.join(File.dirname(__FILE__), "fixtures", "views"))

Dir["#{File.dirname(__FILE__)}/fixtures/models/*.rb"].each { |f| require f }
