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

  def tracked_message
    mail(:track_opens => "true")
  end

  def multipart_message
    mail(:subject => "Your invitation to join Mixlr.") do |format|
      format.text
      format.html
    end
  end

  def message_with_attachment
    attachments['empty.gif'] = File.read(image_file)
    mail(:subject => "Message with attachment.")
  end

  def message_with_inline_image
    attachments.inline['empty.gif'] = File.read(image_file)
    mail(:subject => "Message with inline image.")
  end

  protected

  def image_file
    File.join(File.dirname(__FILE__), '..', '..', 'fixtures', 'empty.gif')
  end

end