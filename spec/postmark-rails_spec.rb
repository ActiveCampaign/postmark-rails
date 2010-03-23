require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "PostmarkRails" do

  it "should use postmark for delivery" do
    Postmark.should_receive(:send_through_postmark) do |message|
      message.subject.should == "hello"
    end
    TestMailer.deliver_simple_message
  end

  it "should allow tagging of message" do
    Postmark.should_receive(:send_through_postmark) do |message|
      message.tag.to_s.should == "delivery"
    end
    TestMailer.deliver_tagged_message
  end

end
