require 'spec_helper'

describe "PostmarkRails3" do
  let!(:api_client) { Postmark::ApiClient.new('api-key') }

  it "should allow setting an api key" do
    ActionMailer::Base.postmark_settings = {:api_key => 'api-key'}
    ActionMailer::Base.postmark_settings[:api_key].should == 'api-key'
  end

  it "should use postmark for delivery" do
    Postmark::ApiClient.should_receive(:new) { api_client }
    api_client.should_receive(:deliver_message) do |message|
      message.subject.should == "hello"
    end
    TestMailer.simple_message.deliver
  end

  it "should allow tagging of message" do
    Postmark::ApiClient.should_receive(:new) { api_client }
    api_client.should_receive(:deliver_message) do |message|
      message.tag.to_s.should == "delivery"
    end
    TestMailer.tagged_message.deliver
  end

  it "should work with multipart messages" do
    Postmark::ApiClient.should_receive(:new) { api_client }
    api_client.should_receive(:deliver_message) do |message|
        message.should be_multipart
        message.body_text.strip.should == "hello"
        message.body_html.strip.should == "<b>hello</b>"
    end
    TestMailer.multipart_message.deliver
  end

  it 'should work with messages containing attachments' do
    Postmark::ApiClient.should_receive(:new) { api_client }
    api_client.should_receive(:deliver_message) do |message|
      message.should have_attachments
    end
    TestMailer.message_with_attachment.deliver
  end
end