# frozen_string_literal: true

module Passwords
  class Create < Service
    def initialize(params:)
      @params = params
    end

    def call
      return valid_email_result unless valid_email_result.success?
      return ServiceResult.new(errors: [I18n.t('services.passwords.create.email_not_found')]) if user.blank?

      send_password_token_email!
    end

    private

    attr_reader :params

    def send_password_token_email!
      user.generate_password_token!
      UserMailer.reset_password_email(user).deliver

      ServiceResult.new(messages: [I18n.t('services.passwords.create.email_sent')])
    end

    def user
      @user ||= User.find_by(email: params[:email])
    end

    def valid_email_result
      @valid_email_result ||= Users::ValidEmail.call(email: params[:email])
    end
  end
end
