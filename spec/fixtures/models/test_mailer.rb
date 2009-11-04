class TestMailer < ActionMailer::Base

  def simple_message
    subject    'hello'
    recipients 'sheldon@bigbangtheory.com'
    from       'leonard@bigbangtheory.com'
  end

  def multipart_message
    subject    'hello'
    recipients 'sheldon@bigbangtheory.com'
    from       'leonard@bigbangtheory.com'
  end

end
