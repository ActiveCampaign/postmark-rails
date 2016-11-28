$:.push File.expand_path("../lib", __FILE__)
require "postmark-rails/version"

Gem::Specification.new do |s|
  s.name = %q{postmark-rails}
  s.version = PostmarkRails::VERSION
  s.authors = ["Petyo Ivanov", "Ilya Sabanin", "Artem Chistyakov"]
  s.description = %q{The Postmark Rails Gem is a drop-in plug-in for ActionMailer to send emails via Postmark, an email delivery service for web apps.}
  s.email = %q{tema@wildbit.com}
  s.homepage = %q{http://postmarkapp.com}
  s.summary = %q{Postmark adapter for ActionMailer}

  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.rdoc_options = ["--charset=UTF-8"]

  s.add_dependency('actionmailer', ">= 3.0.0")
  s.add_dependency('postmark', "~> 1.10.0")

  s.add_development_dependency("rake")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]
end
