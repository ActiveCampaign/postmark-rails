source "https://rubygems.org"

gemspec :path => '../'

gem 'json', '< 2.0.0'
gem 'rake', '< 11.0.0'
gem 'postmark', '~> 1.8.0', :path => ENV['POSTMARK_GEM_PATH']
gem 'actionmailer', '~> 3.2.0'
gem 'i18n', '~> 0.6.0'

group :test do
  gem 'rspec', '~> 2.14.0'
  gem 'mime-types', '~> 1.25.1'
end
