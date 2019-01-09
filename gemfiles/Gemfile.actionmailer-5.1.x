source "https://rubygems.org"

gemspec :path => '../'

gem 'postmark', '~> 1.15.0', path: ENV['POSTMARK_GEM_PATH']
gem 'actionmailer', '~> 5.1.0'

group :test do
  gem 'rspec', '~> 3.7'
  gem 'mime-types', '~> 3.2.2'
end
