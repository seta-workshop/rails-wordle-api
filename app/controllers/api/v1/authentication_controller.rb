# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < Api::V1::ApiController
      skip_before_action :authenticate_request

      def login
        if user&.authenticate(params[:password])
          token = jwt_encode(user_id: user.id)
          render json: {token: token}, status: :ok
        else
          render json: {error: 'unauthorized'}, status: :unauthorized
        end
      end

      private

      def user
        @user ||= User.find_by(email: params[:email])
      end
    end
  end
end
