# frozen_string_literal: true

module Users
  class Leaderboard < Service
    def initialize()

    end

    def call
      return ServiceResult.new(object: leaderboard, messages: I18n.t('global.success'))
    end

    private

    def users
      @users ||= User.all.order('wins DESC')
    end

    def leaderboard
      leaderboard = []
      users.map { |u| leaderboard.push({
        username: u.username,
        wins: u.wins,
        losses: u.losses,
        streak: u.streak,
        best_streak: u.best_streak}) }

      { leaderboard: leaderboard }
    end
  end
end
