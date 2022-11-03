# frozen_string_literal: true

module Users
  class ValidEmail < Service
    def initialize(email:)
      @email = email
    end

    def call
      return ServiceResult.new(errors: [I18n.t('services.users.valid_email.email_not_found')]) if email.blank?
      return ServiceResult.new(errors: [I18n.t('services.users.valid_email.email_format_invalid')]) unless valid?(email)

      ServiceResult.new(messages: [I18n.t('services.users.valid_email.email_format_valid')])
    end

    private

    attr_reader :email

    def valid?(email)
      email =~ URI::MailTo::EMAIL_REGEXP
    end
  end
end
