require 'action_mailer'
require 'postmark'

module PostmarkRails
  extend self

  def install
    ActionMailer::Base.add_delivery_method :postmark, Mail::Postmark, :api_key => nil
  end
end

if defined?(Rails)
  require 'postmark-rails/railtie'
else
  PostmarkRails.install
end
