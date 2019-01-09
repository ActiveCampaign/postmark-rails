require 'spec_helper'

RSpec.describe PostmarkRails::PreviewInterceptor do
  describe '.previewing_email' do
    subject(:preview) { described_class.previewing_email(message) }
    let(:settings) { { :api_token => 'secret' } }

    before do
      ActionMailer::Base.postmark_settings = settings
    end

    context 'when given a templated message' do
      let(:message) do
        Mail::Message.new do
          template_alias 'foo'
        end
      end

      it 'changes the message' do
        message.freeze
        expect { preview }.to raise_error(StandardError, /can't modify/)
      end

      it 'changes delivery method to Postmark and prerenders' do
        expect(message).to receive(:prerender).exactly(1)
        expect { preview }.to change { message.delivery_method }.to(Mail::Postmark)
        expect(message.delivery_method.settings).to eq(settings)
      end
    end

    context 'when given a non-templated message' do
      let(:message) { Mail::Message.new }

      it 'returns the message "as is"' do
        message.freeze
        expect { preview }.to_not raise_error
      end
    end
  end
end
