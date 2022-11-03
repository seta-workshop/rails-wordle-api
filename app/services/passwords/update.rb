# frozen_string_literal: true

module Passwords
  class Update < Service
    def initialize(params:)
      @params = params
    end

    def call
      return ServiceResult.new(errors:[I18n.t('services.passwords.update.new_pswd_blank')]) if params[:password].blank?
      if !user.present? || !user.password_token_valid?
        return ServiceResult.new(errors:[I18n.t('services.passwords.update.link_invalid')])
      end

      update_password!
    end

    private

    attr_reader :params

    def user
      @user ||= User.find_by(reset_password_token: params[:token])
    end

    def update_password!
      user.reset_password!(params[:password])

      ServiceResult.new(messages:[I18n.t('services.passwords.update.pswd_changed')])
    end

  end
end
