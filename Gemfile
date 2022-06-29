source "http://rubygems.org"

gemspec

gem 'actionmailer', ENV.fetch('RAILS_TEST_VERSION', '~> 7.0')

group :test do
  gem 'rspec', '~> 3.7'
  gem 'mime-types', ENV.fetch('MIME_TYPES_TEST_VERSION', '~> 3.1')
end
