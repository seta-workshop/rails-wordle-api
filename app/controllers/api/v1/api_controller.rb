# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      include JsonWebToken
      include ActAsApiRequest

      before_action :authenticate_request
      before_action :check_format
      skip_before_action :verify_authenticity_token

      rescue_from StandardError,                       with: :render_fatal_error
      rescue_from ActiveRecord::RecordNotUnique,       with: :render_fatal_error
      rescue_from ActiveRecord::RecordInvalid,         with: :render_record_error
      rescue_from ActiveRecord::RecordNotSaved,        with: :render_record_error
      rescue_from ActionController::RoutingError,      with: :render_standard_error

      private

      def render_error_json(errors, status = :bad_request)
        render json: { errors: errors }, status: status
      end

      def render_standard_error(exception)
        render_error_json(exception.message)
      end

      def render_record_error(exception)
        render_error_json(exception.record.errors.full_messages.join('\n'))
      end

      def render_fatal_error(exception)
        render_error_json(I18n.t('errors.standard_error'))
      end

      def authenticate_request
        header = request.headers["Authorization"]
        header = header.split(" ").last if header
        decoded = jwt_decode(header)
        @current_user = User.find(decoded[:user_id])
      end

      def current_user
        @current_user
      end
    end
  end
end
