# frozen_string_literal: true

module Users
  class ValidateEmailUpdate < Service
    def initialize(current_user:, params:)
      @params = params
      @current_user = current_user
    end

    def call
      return ServiceResult.new(errors:I18n.t('services.users.validate_email_update.email_not_found')) if params[:unconfirmed_email].blank?

      validate_email_update
    end

    private

    attr_reader :params

    def validate_email_update
      return ServiceResult.new(errors:[I18n.t('services.users.validate_email_update.current_email_equals_current_email')]) if params[:unconfirmed_email] == @current_user.email
      return ServiceResult.new(errors:[I18n.t('services.users.validate_email_update.email_in_use')]) if User.email_used?(params[:unconfirmed_email])

      return ServiceResult.new(messages: [I18n.t('global.success')])
    end
  end
end
