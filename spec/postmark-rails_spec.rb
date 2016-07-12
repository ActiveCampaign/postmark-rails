require 'spec_helper'

describe "PostmarkRails3" do
  let!(:api_client) { Postmark::ApiClient.new('api-token') }

  def deliver(message)
    if message.respond_to?(:deliver_now)
      message.deliver_now
    else
      message.deliver
    end
  end

  it 'should allow setting an api token' do
    ActionMailer::Base.postmark_settings = {:api_token => 'api-token'}
    expect(ActionMailer::Base.postmark_settings[:api_token]).to eq('api-token')
  end

  it "should use postmark for delivery" do
    expect(Postmark::ApiClient).to receive(:new) { api_client }
    expect(api_client).to receive(:deliver_message) do |message|
      expect(message.subject).to eq("hello")
    end
    deliver(TestMailer.simple_message)
  end

  it "should allow tagging of message" do
    expect(Postmark::ApiClient).to receive(:new) { api_client }
    expect(api_client).to receive(:deliver_message) do |message|
      expect(message.tag.to_s).to eq("delivery")
    end
    deliver(TestMailer.tagged_message)
  end

  it "allows to enable open tracking" do
    expect(Postmark::ApiClient).to receive(:new) { api_client }
    expect(api_client).to receive(:deliver_message) do |message|
      expect(message.track_opens).to be_true
      expect(message.to_postmark_hash['TrackOpens']).to be_true
    end
    deliver(TestMailer.tracked_message)
  end

  it "should work with multipart messages" do
    expect(Postmark::ApiClient).to receive(:new) { api_client }
    expect(api_client).to receive(:deliver_message) do |message|
      expect(message).to be_multipart
      expect(message.body_text.strip).to eq("hello")
      expect(message.body_html.strip).to eq("<b>hello</b>")
    end
    deliver(TestMailer.multipart_message)
  end

  it 'should work with messages containing attachments' do
    expect(Postmark::ApiClient).to receive(:new) { api_client }
    expect(api_client).to receive(:deliver_message) do |message|
      expect(message).to have_attachments
    end
    deliver(TestMailer.message_with_attachment)
  end
end