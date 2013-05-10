require 'spec_helper'

describe "Delivering messages with postmark-rails" do
  let(:api_key) { 'POSTMARK_API_TEST' }

  before do
    ActionMailer::Base.postmark_settings = { :api_key => api_key }
  end

  it 'delivers a simple message' do
    message = TestMailer.simple_message

    expect { message.deliver }.to change{message.delivered?}.to(true)
  end

  it 'delivers a tagged message' do
    message = TestMailer.tagged_message

    expect { message.deliver }.to change{message.delivered?}.to(true)
  end

  it 'delivers a multipart message' do
    message = TestMailer.multipart_message

    expect { message.deliver }.to change{message.delivered?}.to(true)
  end

  it 'delivers a message with attachments' do
    message = TestMailer.message_with_attachment

    expect { message.deliver }.to change{message.delivered?}.to(true)
  end
end