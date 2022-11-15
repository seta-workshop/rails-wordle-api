# frozen_string_literal: true

module Api
  module V1
    class LeaderboardController < Api::V1::ApiController
      def index
        result = Leaderboard::Leaderboard.call
        if result.success?
          render(json: { object: result.object, messages: result.messages }, status: :ok)
        else
          render(json: { errors: result.errors }, status: :bad_request)
        end
      end
    end
  end
end
