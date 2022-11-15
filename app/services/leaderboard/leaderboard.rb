# frozen_string_literal: true
module Leaderboard
  class Leaderboard < Service
    def call
      return ServiceResult.new(errors: I18n.t('services.leaderboard.index.errors')) unless users.any?

      ServiceResult.new(object: {leaderboard: users}, messages: I18n.t('global.success'))
    end

    private

    def users
      @users ||= User.order('wins DESC').select(:id, :username, :wins, :losses, :streak, :best_streak)
    end
  end
end
