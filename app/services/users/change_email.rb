# frozen_string_literal: true

module Users
  class ChangeEmail < Service
    def initialize(params:)
      @params = params
    end

    def call
      if !user || !user.email_token_valid?
        return ServiceResult.new(errors:['The link is invalid or it\'s expired.'])
      end

      change_email!
    end

    private

    attr_reader :params

    def user
      @user ||= User.find_by(reset_email_token: (params[:token].to_s))
    end

    def change_email!
      user.change_email!
      ServiceResult.new(messages: ["Email updated successfully!"])
    end
  end
end
