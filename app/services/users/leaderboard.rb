module Users
  class Leaderboard < Service
    def initialize(params: )
      @params = params
    end

    def call
      return ServiceResult.new(object: leaderboard)
    end

    private

    attr_reader :params

    def users
      @users ||= User.all.order('wins DESC')
    end

    def leaderboard
      leaderboard = []
      users.each do |u|
        stats = (
          {
            username: u.username,
            wins: u.wins,
            losses: u.losses,
            streak: u.streak,
            best_streak: u.best_streak}
          )
        leaderboard.push(stats)
      end

      return ({leaderboard: leaderboard})
    end
  end
end
