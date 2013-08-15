require 'action_mailer'
require 'postmark'

module PostmarkRails
  extend self

  def install_in_rails
    ActionMailer::Base.add_delivery_method :postmark, Mail::Postmark, :api_key => nil
  end
end

PostmarkRails.install_in_rails
