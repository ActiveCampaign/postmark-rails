$:.push File.expand_path("../lib", __FILE__)
require "postmark-rails/version"

Gem::Specification.new do |s|
  s.name = %q{postmark-rails}
  s.version = Postmark::Rails::VERSION
  s.authors = ["Petyo Ivanov", "Ilya Sabanin", "Artem Chistyakov"]
  s.description = %q{Use this plugin in your rails applications to send emails through the Postmark API}
  s.email = %q{ilya@wildbit.com}
  s.homepage = %q{http://postmarkapp.com}
  s.summary = %q{Postmark adapter for ActionMailer}

  s.post_install_message = %q{
    ==================
    Thanks for installing the postmark-rails gem. If you don't have an account, please sign up at http://postmarkapp.com/.
    Review the README.rdoc for implementation details and examples.
    ==================
  }

  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.rdoc_options = ["--charset=UTF-8"]

  s.add_dependency('actionmailer')
  s.add_dependency('postmark', "~> 1.0")
  s.add_development_dependency('rake')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]
end

