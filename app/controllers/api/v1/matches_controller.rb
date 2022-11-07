# frozen_string_literal: true

module Api
  module V1
    class MatchesController < Api::V1::ApiController
      def create
        result = ::Matches::Create.call(params: params, user: current_user)
        if result.success?
          render(json: { object: result.object, messages:result.messages, status: :ok })
        else
          render(json: { errors:result.errors, status: :bad_request })
        end
      end
    end
  end
end
