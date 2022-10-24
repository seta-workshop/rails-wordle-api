# frozen_string_literal: true

module Attempts
  class Create < Service

    def initialize(user: )
      @user = user
    end

    def call
      return ServiceResult.new(errors: ['User not present']) unless user

      ServiceResult.new(object: attempt, messages:["Attempt: #{attempt.count}, Match: #{match.id}"])
    end

    private

    def attempt!
      count = @match.attempts.count
      @match.attempts.find_or_create_by!(match_id: match.id, user_id: user.id, count: count)
    end

    def match
      range = (Time.current.beginning_of_day..Time.current.end_of_day)
      @match ||= Match.where(user_id: user.id, created_at: range)
    end

  end
end
