source "https://rubygems.org"

gemspec :path => '../'

gem 'postmark', '~> 1.22', path: ENV['POSTMARK_GEM_PATH']
gem 'actionmailer', '~> 7.0.0'

group :test do
  gem 'rspec', '~> 3.7'
  gem 'mime-types', '~> 3.2.2'
end
