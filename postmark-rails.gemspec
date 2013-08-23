$:.push File.expand_path("../lib", __FILE__)
require "postmark-rails/version"

Gem::Specification.new do |s|
  s.name = %q{postmark-rails}
  s.version = PostmarkRails::VERSION
  s.authors = ["Petyo Ivanov", "Ilya Sabanin", "Artem Chistyakov"]
  s.description = %q{Use this plugin in your rails applications to send emails through the Postmark API}
  s.email = %q{ilya@wildbit.com}
  s.homepage = %q{http://postmarkapp.com}
  s.summary = %q{Postmark adapter for ActionMailer}

  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.rdoc_options = ["--charset=UTF-8"]

  s.add_dependency('actionmailer', ">= 3.0.0")
  s.add_dependency('postmark', "~> 1.0")
  s.add_development_dependency('rake')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]
end

