# frozen_string_literal: true

module Users
  class ValidEmail < Service
    def initialize(email:)
      @email = email
    end

    def call
      return ServiceResult.new(errors: ['Email cannot be blank']) if email.blank?
      return ServiceResult.new(errors: ['Email format is invalid']) unless valid?(email)

      ServiceResult.new(messages: ['Email format is valid'])
    end

    private

    attr_reader :email

    def valid?(email)
      email =~ URI::MailTo::EMAIL_REGEXP
    end
  end
end
