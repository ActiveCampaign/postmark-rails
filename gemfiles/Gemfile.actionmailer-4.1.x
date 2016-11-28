source "https://rubygems.org"

gemspec :path => '../'

gem 'json', '< 2.0.0'
gem 'postmark', '~> 1.10.0', path: ENV['POSTMARK_GEM_PATH']
gem 'actionmailer', '~> 4.1.0'

group :test do
  gem 'rspec', '~> 2.14.0'
  gem 'mime-types', '~> 1.25.1'
end
