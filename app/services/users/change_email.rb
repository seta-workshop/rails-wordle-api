# frozen_string_literal: true

module Users
  class ChangeEmail < Service
    def initialize(params:)
      @params = params
    end

    def call
      if !user || !user.email_token_valid?
        return ServiceResult.new(errors:[I18n.t('services.users.change_email.link_invalid')])
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
      ServiceResult.new(messages: [I18n.t('services.users.change_email.updated_successfully')])
    end
  end
end
