module PostmarkRails
  class Railtie < Rails::Railtie
    initializer 'postmark-rails' do
      ActiveSupport.on_load :action_mailer do
        PostmarkRails.install
      end
    end
  end
end
