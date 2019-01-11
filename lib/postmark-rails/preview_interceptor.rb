module PostmarkRails
  class PreviewInterceptor
    def self.previewing_email(message)
      return unless message.templated?

      message.delivery_method(::Mail::Postmark, ::ActionMailer::Base.postmark_settings)
      message.prerender
    end
  end
end
