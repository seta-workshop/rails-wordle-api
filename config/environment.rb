# frozen_string_literal: true

# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
  :password => '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', # This is the secret sendgrid API key which was issued during API key creation
  :domain => 'agustin@setaworkshop.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
