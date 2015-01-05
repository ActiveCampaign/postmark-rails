require 'spec_helper'

describe "Delivering messages with postmark-rails" do
  let(:api_token) { 'POSTMARK_API_TEST' }

  before do
    ActionMailer::Base.postmark_settings = { :api_token => api_token }
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
    request = message.to_postmark_hash

    expect(request['Attachments'].count).not_to be_zero
    expect { message.deliver }.to change{message.delivered?}.to(true)
  end

  it 'delivers a message with inline image' do
    message = TestMailer.message_with_inline_image
    request = message.to_postmark_hash

    expect(request['Attachments'].count).not_to be_zero
    expect(request['Attachments'].first).to have_key('ContentID')
    expect { message.deliver }.to change{message.delivered?}.to(true)
  end

end