require 'active_support/rescuable'
require 'action_mailer'
require 'postmark'

module PostmarkRails
  module ActionMailerExtensions
    def metadata
      @_message.metadata
    end

    def metadata=(val)
      @_message.metadata=(val)
    end
  end

  def self.install
    require 'postmark-rails/preview_interceptor'
    require 'postmark-rails/templated_mailer'
    ActionMailer::Base.add_delivery_method :postmark, Mail::Postmark
    ActionMailer::Base.send(:include, ActionMailerExtensions)
  end
end

if defined?(Rails)
  require 'postmark-rails/railtie'
else
  PostmarkRails.install
end
