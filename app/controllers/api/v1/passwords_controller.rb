# frozen_string_literal: true

module Api
  module V1
    class PasswordsController < Api::V1::ApiController
      skip_before_action :authenticate_request, only: [:create, :update]

      def create
        result = Passwords::Create.call(params: params)
        if result.success?
          render json: {message: result.messages}
        else
          render json: { errors: result.errors }, status: :bad_request
        end
      end

      def update
        result = Passwords::Update.call(params: params)
        if result.success?
          render json: { message: result.messages }
        else
          render json: { errors: result.errors }, status: :bad_request
        end
      end

    end
  end
end
