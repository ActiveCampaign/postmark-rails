def require_local(lib)
  require File.join(File.dirname(__FILE__), 'lib', lib)
end

require_local 'postmark_installer'
require_local 'postmark_delivery_method'

#
# Will detect your Rails version automatically
# and install Postmark delivery method into ActionMailer properly.
#
PostmarkInstaller.auto_detect_and_install