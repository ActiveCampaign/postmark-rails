require 'postmark'

module PostmarkMethods
  def perform_delivery_postmark(message)
    Postmark.send_through_postmark(message)
  end
end

class ActionMailer::Base
  include PostmarkMethods

  def self.postmark_api_key=(value)
    Postmark.api_key = value
  end
end
