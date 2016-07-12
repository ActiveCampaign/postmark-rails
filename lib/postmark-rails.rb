require 'active_support/rescuable'
require 'action_mailer'
require 'postmark'

module PostmarkRails
  extend self

  def install
    ActionMailer::Base.add_delivery_method :postmark, Mail::Postmark
  end
end

if defined?(Rails)
  require 'postmark-rails/railtie'
else
  PostmarkRails.install
end
