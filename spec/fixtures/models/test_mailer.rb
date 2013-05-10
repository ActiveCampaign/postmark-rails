class TestMailer < ActionMailer::Base
  default :subject  => 'hello',
          :to       => 'sheldon@bigbangtheory.com',
          :from     => 'leonard@bigbangtheory.com'

  def simple_message
    mail
  end

  def tagged_message
    mail(:tag => 'delivery')
  end

  def multipart_message
    mail(:subject => "Your invitation to join Mixlr.") do |format|
      format.text
      format.html
    end
  end

  def message_with_attachment
    attachments['empty.gif'] = File.join(File.dirname(__FILE__), '..', '..', 'fixtures', 'empty.gif')
    mail(:subject => "Message with attachment.")
  end
end