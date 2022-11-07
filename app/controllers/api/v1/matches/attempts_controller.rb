# frozen_string_literal: true

module Api
  module V1
    module Matches
      class AttemptsController < Api::V1::ApiController
        def create
          result = ::Attempts::Create.call(match: match, params: params)

          if result.success?
            render(json: { attempt: result.object, messages: result.messages, status: :ok })
          else
            render(json: { errors: result.errors }, status: :bad_request)
          end
        end

        private

        def match
          @match ||= current_user.matches.find(params[:match_id])
        end
      end
    end
  end
end
