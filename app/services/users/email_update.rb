# frozen_string_literal: true

module Users
  class EmailUpdate < Service
    def initialize(params:)
      @params = params
    end

    def call
      return valid_email_result unless valid_email_result.success?
      return valid_unconfirmed_email_result unless valid_unconfirmed_email_result.success?
      return ServiceResult.new(errors:[I18n.t('services.users.email_update.wrong_credentials')]) unless user
      email_update!
    end

    private

    attr_reader :params, :user

    def email_update!
      user.new_email_update!(params[:unconfirmed_email])
      user.generate_email_token!
      UserMailer.reset_email_email(user).deliver
      ServiceResult.new(messages:[I18n.t('services.users.email_update.confirmation_email_sent')])
    end

    def user
      @user ||= User.find_by(email: (params[:email]))
    end

    def valid_email_result
      @valid_email_result ||= Users::ValidEmail.call(email: params[:email])
    end

    def valid_unconfirmed_email_result
      @valid_unconfirmed_email_result ||= Users::ValidEmail.call(email: params[:unconfirmed_email])
    end
  end
end
