require 'spec_helper'

describe 'Delivering emails in batches' do
  let(:api_client) { Postmark::ApiClient.new('POSTMARK_API_TEST') }
  let(:messages) { [TestMailer.simple_message,
                    TestMailer.tagged_message,
                    TestMailer.multipart_message,
                    TestMailer.message_with_attachment] }

  it 'delivers messages in batches' do
    expect { api_client.deliver_messages(messages) }.
        to change{messages.all? { |m| m.delivered?} }.to true
  end
end