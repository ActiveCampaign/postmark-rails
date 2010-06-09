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

  def tagged_message
    subject    'hello'
    recipients 'sheldon@bigbangtheory.com'
    from       'leonard@bigbangtheory.com'
    tag        'delivery'
  end

  def multipart_message
    recipients "sheldon@bigbangtheory.com"
    from       'leonard@bigbangtheory.com'
    subject "Your invitation to join Mixlr." 
    sent_on Time.now 
    content_type "multipart/alternative"
    part :content_type => "text/plain", :body => "plain text"
    part :content_type => "text/html", :body => "html text"
  end

end
