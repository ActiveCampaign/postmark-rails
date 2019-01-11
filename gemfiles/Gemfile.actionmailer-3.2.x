source "https://rubygems.org"

gemspec :path => '../'

gem 'json', '< 2.0.0'
gem 'rake', '< 11.0.0'
gem 'postmark', '~> 1.15.0', :path => ENV['POSTMARK_GEM_PATH']
gem 'actionmailer', :github => 'rails', :branch => '3-2-stable'
gem 'i18n', '~> 0.6.0'
gem 'rack-cache', '~> 1.2.0'

group :test do
  gem 'rspec', '~> 3.7'
  gem 'mime-types', '~> 1.25.1'
end
