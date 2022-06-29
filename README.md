<a href="https://postmarkapp.com">
    <img src="postmark.png" alt="Postmark Logo" title="Postmark" width="120" height="120" align="right">
</a>

# Postmark Rails Gem

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/ActiveCampaign/postmark-rails/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/ActiveCampaign/postmark-rails/tree/main)
[![Code Climate](https://codeclimate.com/github/ActiveCampaign/postmark-rails/badges/gpa.svg)](https://codeclimate.com/github/ActiveCampaign/postmark-rails)
[![License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://www.opensource.org/licenses/MIT)
[![Gem Version](https://badge.fury.io/rb/postmark-rails.svg)](https://badge.fury.io/rb/postmark-rails)

[Postmark](https://postmarkapp.com) allows you to send your emails with high delivery rates.
It also includes detailed statistics. In addition, Postmark can parse incoming emails which are forwarded back to your application.

The Postmark Rails Gem is a drop-in plug-in for ActionMailer to send emails via [Postmark](https://postmarkapp.com).
The gem has been created for fast implementation and fully supports all of [Postmark’s features](https://postmarkapp.com/why).

## Usage

Please see the [wiki](https://github.com/ActiveCampaign/postmark-rails/wiki) for detailed instructions about library features.
For details about Postmark API in general, please check out [Postmark developer docs](https://postmarkapp.com/developer).

## Requirements

You will need a Postmark account, server and sender signature (or verified domain) set up to use it.
For details about setup, check out [wiki pages](https://github.com/ActiveCampaign/postmark-rails/wiki/Getting-Started).

Also you will need a [postmark gem](https://github.com/ActiveCampaign/postmark-gem) version 1.0 and higher is required.

### Supported Rails Versions

- Rails 7.0
- Rails 6.0
- Rails 5.0
- Rails 4.x
- Rails 3.x

For Rails 2.3 please take a look at [version 0.4](https://github.com/ActiveCampaign/postmark-rails/tree/v0.4.2).
It may miss some new features, but receives all required bug fixes and other support if needed.

## Installation

Add `postmark-rails` to your Gemfile and run `bundle install`.

```ruby
gem 'postmark-rails'
```

## Rails 6-7

Save your Postmark Server API Token to [config/credentials.yml.enc](https://guides.rubyonrails.org/security.html#custom-credentials):

run `rails secret`, then run `rails credentials:edit` and add:

```yaml
postmark_api_token: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

Set Postmark as your preferred mail delivery method via `config/application.rb`:

```ruby
config.action_mailer.delivery_method = :postmark
config.action_mailer.postmark_settings = { api_token: Rails.application.credentials.postmark_api_token }
```

## Rails 3-5

Save your Postmark Server API token to [config/secrets.yml](http://guides.rubyonrails.org/4_1_release_notes.html#config-secrets-yml).

```yaml
postmark_api_token: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

Set Postmark as your preferred mail delivery method via `config/application.rb`:

```ruby
config.action_mailer.delivery_method = :postmark
config.action_mailer.postmark_settings = { :api_token => Rails.application.secrets.postmark_api_token }
```

---

**Note**: The `postmark_settings` hash can contain [any options](https://github.com/ActiveCampaign/postmark-gem#communicating-with-the-api) supported by `Postmark::ApiClient`.

### Additional information

Looking for the advanced usage examples? Check out [the documentation](https://github.com/ActiveCampaign/postmark-gem/blob/main/README.md) for the [postmark gem](https://github.com/ActiveCampaign/postmark-gem).
The `postmark-rails` gem is built on top of it, so you can benefit from all it's features.

## Note on Patches/Pull Requests

See [CONTRIBUTING.md](CONTRIBUTING.md) file for details.

## Authors & Contributors

- Artem Chistyakov
- Petyo Ivanov
- Ilya Sabanin
- Hristo Deshev
- Randy Schmidt
- Chris Williams
- Nicolás Sanguinetti
- Laust Rud Jacobsen (rud)

## Issues & Comments

Feel free to contact us if you encounter any issues with the library or Postmark API.
Please leave all comments, bugs, requests and issues on the Issues page.

## License

The Postmark Rails gem is licensed under the [MIT](http://www.opensource.org/licenses/mit-license.php) license.
Refer to the [LICENSE](https://github.com/ActiveCampaign/postmark-rails/blob/main/LICENSE) file for more information.

## Copyright

Copyright © 2022 ActiveCampaign LLC.
