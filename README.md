# postmark-rails gem

[![Build Status](https://travis-ci.org/wildbit/postmark-rails.svg?branch=master)](https://travis-ci.org/wildbit/postmark-rails) [![Code Climate](https://codeclimate.com/github/wildbit/postmark-rails/badges/gpa.svg)](https://codeclimate.com/github/wildbit/postmark-rails)

The Postmark Rails Gem is a drop-in plug-in for ActionMailer to send emails via [Postmark](https://postmarkapp.com), an email delivery service for web apps. The gem has been created for fast implementation and fully supports all of [Postmark’s features](https://postmarkapp.com/why).

## Supported Rails Versions

* Rails 5.0
* Rails 4.x
* Rails 3.x

For Rails 2.3 please take a look at [version 0.4](https://github.com/wildbit/postmark-rails/tree/v0.4.2). It may miss some new features, but receives all required bug fixes and other support if needed.

## Configuring your Rails application

Add `postmark-rails` to your Gemfile (change version numbers if needed) and run `bundle install`.

``` ruby
gem 'postmark-rails', '~> 0.15.0'
```

Save your Postmark API token to [config/secrets.yml](http://guides.rubyonrails.org/4_1_release_notes.html#config-secrets-yml).

``` yaml
postmark_api_token: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

Set Postmark as your preferred mail delivery method via `config/application.rb`:

``` ruby
config.action_mailer.delivery_method = :postmark
config.action_mailer.postmark_settings = { :api_token => Rails.application.secrets.postmark_api_token }
```

**Note**: The `postmark_settings` hash can contain [any options](https://github.com/wildbit/postmark-gem#communicating-with-the-api) supported by `Postmark::ApiClient`.

## Tracking opens and tagging your deliveries

You can use tags to categorize outgoing messages and attach application-specific information. Tagging the different types of email that you send lets you [review statistics and bounce reports separately](http://developer.postmarkapp.com/developer-build.html#message-format).

Pass `:track_opens => 'true'` to enable/disable open tracking on per-message basis. Check out the [Triggers API](https://github.com/wildbit/postmark-gem/wiki/The-Triggers-API-Support) to see how Postmark can help you control this with tags. **Note that we pass a string here, since it becomes a header value. Passing a boolean may or may not work depending on your Rails version.**

``` ruby
class TestMailer < ActionMailer::Base

  def tagged_message
    mail(
      :subject => 'hello',
      :to      => 'sheldon@bigbangtheory.com',
      :from    => 'leonard@bigbangtheory.com',
      :tag     => 'my-tag',
      :track_opens => 'true'
    )
  end

end
```

## Sending attachments

You can also send file attachments with Postmark. Read our Developer docs for [additional information](http://developer.postmarkapp.com/developer-build.html#attachments).

The Postmark gem is compatible with [ActionMailer attachments API](http://api.rubyonrails.org/classes/ActionMailer/Base.html#method-i-attachments). It allows you to specify the name, content-type and other attributes for your attachments.

The legacy `:postmark_attachments` attribute is *no longer supported* on Rails 3.2.13 and above.

``` ruby
class TestMailer < ActionMailer::Base

  def message_with_attachment
    attachments.inline['logo.png'] = File.read("/path/to/image") # Inline image
    attachments['42.jpg'] = File.read("/path/to/file") # Attached file
    mail(
      :subject              => 'hello',
      :to                   => 'sheldon@bigbangtheory.com',
      :from                 => 'leonard@bigbangtheory.com'
    )
  end

end
```

## Sending in batches

While Postmark is focused on transactional email, we understand that developers
with higher volumes or processing time constraints need to send their messages
in batches. To facilitate this we provide a batching endpoint that permits you
to send up to 500 well-formed Postmark messages in a single API call.

``` ruby
client = Postmark::ApiClient.new('your-api-token')

messages = []
messages << DigestMailer.weekly_digest(@user1)
messages << DigestMailer.weekly_digest(@user2)

client.deliver_messages(messages)

messages.first.delivered?
# => true

messages.all?(&:delivered)
# => true
```

## Error handling

The gem respects the `ActionMailer::Base.raise_delivery_errors` setting and will surpress any exceptions
if it’s set to `false`. When delivery errors are enabled, the gem can raise any one of the exceptions
listed in the [postmark](https://github.com/wildbit/postmark-gem#error-handling) gem docs.


### ActionMailer 5

For ActionMailer 5 and above, use `ActionMailer::Base.rescue_from` to define handlers for
each error you care about.

#### Example

``` ruby
class ApplicationMailer < ActionMailer::Base
  default from: 'user@example.org'
  layout 'mailer'

  rescue_from Postmark::InactiveRecipientError, with: :reactivate_and_retry

  private

  def postmark_client
    ::Postmark::ApiClient.new(ActionMailer::Base.postmark_settings[:api_token],
                              ActionMailer::Base.postmark_settings.except(:api_token))
  end


  # This is just an example. Sometimes you might not want to reactivate
  # an address that hard bounced.
  # Warning: Having too many bounces can affect your delivery reputation
  # with email providers
  def reactivate_and_retry(error)
    Rails.logger.info("Error when sending #{message} to #{error.recipients.join(', ')}")
    Rails.logger.info(error)

    error.recipients.each do |recipient|
      bounce = postmark_client.bounces(emailFilter: recipient).first
      next unless bounce
      postmark_client.activate_bounce(bounce[:id])
    end

    # Try again immediately
    message.deliver
  end
end
```

### ActionMailer 4 and below

Wrap any calls to `#deliver_now` in error handlers like the one described
in the [postmark](https://github.com/wildbit/postmark-gem#error-handling) gem
docs.

Rails 4.2 introduces `#deliver_later` but doesn’t support `rescue_from` for
mailer classes. Instead, use the following monkey patch for
`ActionMailer::DeliveryJob`.

``` ruby
# app/mailers/application_mailer.rb

class ApplicationMailer < ActionMailer::Base
  default from: 'user@example.org'
end

class ActionMailer::DeliveryJob
  rescue_from Postmark::InactiveRecipientError, with: :reactivate_and_retry

  def postmark_client
    ::Postmark::ApiClient.new(ActionMailer::Base.postmark_settings[:api_token],
                              ActionMailer::Base.postmark_settings.except(:api_token))
  end


  # This is just an example. Sometimes you might not want to reactivate
  # an address that hard bounced.
  # Warning: Having too many bounces can affect your delivery reputation
  # with email providers
  def reactivate_and_retry(error)
    Rails.logger.info("Error when sending a message to #{error.recipients.join(', ')}")
    Rails.logger.info(error)

    error.recipients.each do |recipient|
      bounce = postmark_client.bounces(emailFilter: recipient).first
      next unless bounce
      postmark_client.activate_bounce(bounce[:id])
    end

    # Try again immediately
    perform(*arguments)
  end
end
```

## Additional information

Looking for the advanced usage examples? Check out [the documentation](https://github.com/wildbit/postmark-gem/blob/master/README.md) for the `postmark` gem. The `postmark-rails` gem is built on top of it, so you can benefit from all its features.

## Requirements

* `postmark` gem version 1.0 and higher is required.
* You will also need a Postmark account, a server and at least one sender signature set up to use it. To get an account, [sign up](https://postmarkapp.com/sign_up)!


## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so we don’t break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
* Send a pull request. Bonus points for topic branches.

## Authors & Contributors

* Artem Chistyakov
* Petyo Ivanov
* Ilya Sabanin
* Hristo Deshev
* Randy Schmidt
* Chris Williams
* Nicolás Sanguinetti
* Laust Rud Jacobsen (rud)

## Copyright

Copyright © 2010—2018 Wildbit LLC. See LICENSE for details.
