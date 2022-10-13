# frozen_string_literal: true

module Passwords
  class Update < Service
    def initialize(params:)
      @params = params
    end

    def call
      return ServiceResult.new(errors:['New password not present']) if params[:password].blank?
      if !user.present? || !user.password_token_valid?
        return ServiceResult.new(errors:['Link not valid or expired. Try generating new link.'])
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

      ServiceResult.new(messages:['Password has been changed'])
    end

  end
end
