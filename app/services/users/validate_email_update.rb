# frozen_string_literal: true

module Users
  class ValidateEmailUpdate < Service
    def initialize(current_user:, params:)
      @params = params
      @current_user = current_user
    end

    def call
      return ServiceResult.new(errors:"Email not found or is blank.") if params[:unconfirmed_email].blank?

      validate_email_update
    end

    private

    attr_reader :params

    def validate_email_update
      return ServiceResult.new(errors:['Current Email and New Email cannot be the same']) if params[:unconfirmed_email] == @current_user.email
      return ServiceResult.new(errors:['Email already in use.']) if User.email_used?(params[:unconfirmed_email])

      return ServiceResult.new(messages: ['Success'])
    end
  end
end
