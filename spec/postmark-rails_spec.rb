require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "PostmarkRails" do
  it "should use postmark for delivery" do
    Postmark.should_receive(:send_through_postmark) do |message|
      message.subject.should == "hello"
    end
    TestMailer.deliver_simple_message
  end

end
