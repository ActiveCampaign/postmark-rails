require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "PostmarkRails3" do
  it "should allow setting an api key" do
    Postmark.stub!(:send_through_postmark)
    ActionMailer::Base.postmark_settings = {:api_key => 'api-key'}
    ActionMailer::Base.postmark_settings[:api_key].should == 'api-key'
    Postmark.should_receive(:api_key=).with('api-key')
    TestMailer.simple_message.deliver
  end
  
  it "should use postmark for delivery" do
    Postmark.should_receive(:send_through_postmark) do |message|
      message.subject.should == "hello"
    end
    TestMailer.simple_message.deliver
  end

  it "should allow tagging of message" do
    Postmark.should_receive(:send_through_postmark) do |message|
      message.tag.to_s.should == "delivery"
    end
    TestMailer.tagged_message.deliver
  end
  
  it "should work with multipart messages" do
    Postmark.should_receive(:send_through_postmark) do |message|
        message.should be_multipart
        message.body_text.strip.should == "hello"
        message.body_html.strip.should == "<b>hello</b>"
    end
    TestMailer.multipart_message.deliver
  end
end