# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      include JsonWebToken
      include ActAsApiRequest

      before_action :authenticate_request
      before_action :check_format
      skip_before_action :verify_authenticity_token

      private

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
