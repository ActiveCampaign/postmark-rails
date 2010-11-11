#
# This module is only used for Rails 2.
#
module PostmarkDeliveryMethod
  
  module ClassMethods
    
    def postmark_api_key=(value)
      Postmark.api_key = value
    end
    
  end
  
  def self.included(base)
    base.extend(ClassMethods)
    
    base.class_eval do      
      alias_method_chain :create_mail, :postmark_extras
    end
  end
  
  def perform_delivery_postmark(message)
    Postmark.send_through_postmark(message)
  end

  def tag(value)
    @tag = value
  end
  
  def postmark_attachments(value)
    @attachments = value
  end

  def create_mail_with_postmark_extras
    create_mail_without_postmark_extras.tap do |mail|
      mail.tag = @tag                          if @tag
      mail.postmark_attachments = @attachments if @attachments
    end
  end
  
end