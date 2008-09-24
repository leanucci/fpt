# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.1.1' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random,
  # no regular words or you'll be exposed to dictionary attacks.

  config.action_controller.session = {
    :session_key => '_fpt_session',
    :secret      => '6760b94083ce171efdb62e05fcbce616bac9e57355c54f9cf28215431a19068588a0939915d039cd13528f28b787058d3c9ada4bdb47060e0726b88045e78e45'
  }

  # config.action_controller.session_store  = :active_record_store
  config.active_record.default_timezone   = :utc
end
