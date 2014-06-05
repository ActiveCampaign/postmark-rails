require 'spec_helper'

describe "PostmarkRails3" do
  let!(:api_client) { Postmark::ApiClient.new('api-key') }

  it "should allow setting an api key" do
    ActionMailer::Base.postmark_settings = {:api_key => 'api-key'}
    expect(ActionMailer::Base.postmark_settings[:api_key]).to eq('api-key')
  end

  it "should use postmark for delivery" do
    expect(Postmark::ApiClient).to receive(:new) { api_client }
    expect(api_client).to receive(:deliver_message) do |message|
      expect(message.subject).to eq("hello")
    end
    TestMailer.simple_message.deliver
  end

  it "should allow tagging of message" do
    expect(Postmark::ApiClient).to receive(:new) { api_client }
    expect(api_client).to receive(:deliver_message) do |message|
      expect(message.tag.to_s).to eq("delivery")
    end
    TestMailer.tagged_message.deliver
  end

  it "allows to enable open tracking" do
    expect(Postmark::ApiClient).to receive(:new) { api_client }
    expect(api_client).to receive(:deliver_message) do |message|
      expect(message.track_opens).to be_true
      expect(message.to_postmark_hash['TrackOpens']).to be_true
    end
    TestMailer.tracked_message.deliver
  end

  it "should work with multipart messages" do
    expect(Postmark::ApiClient).to receive(:new) { api_client }
    expect(api_client).to receive(:deliver_message) do |message|
      expect(message).to be_multipart
      expect(message.body_text.strip).to eq("hello")
      expect(message.body_html.strip).to eq("<b>hello</b>")
    end
    TestMailer.multipart_message.deliver
  end

  it 'should work with messages containing attachments' do
    expect(Postmark::ApiClient).to receive(:new) { api_client }
    expect(api_client).to receive(:deliver_message) do |message|
      expect(message).to have_attachments
    end
    TestMailer.message_with_attachment.deliver
  end
end