# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < Api::V1::ApiController
      skip_before_action :authenticate_request

      def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
          token = jwt_encode(user_id: @user.id)
          render json: {token: token}, status: :ok
        else
          render json: {error: 'unauthorized'}, status: :unauthorized
        end
      end
    end
  end
end