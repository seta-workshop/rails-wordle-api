
module Attempts
  class CheckAnswer < Service
    PLAYING = 0
    WIN = 1
    LOSE = 2

    def initialize(match: ,params:)
      @match = match.reload
      @params = params
    end

    def call
      update_match_and_attempts

      ServiceResult.new(object: { status: match.status, attempts_count: match.attempts.count, match_id: match.id })
    end

    private
    attr_reader :match, :params

    def user
      @user ||= User.find_by(id: match.user_id)
    end

    def word
      @word ||= params[:word].downcase
    end

    def match_word
      @match_word ||= Word.find(match.word_id).value.downcase
    end

    def update_win
      match.finished_at = DateTime.current
      match.status = WIN
      user.streak += 1
      user.best_streak = user.streak unless user.best_streak > user.streak
      user.wins += 1
      user.save!
      match.save!
      status = WIN
    end

    def update_match_and_attempts
      return update_win if word == match_word
      if match.attempts.count >= 5
        match.finished_at = DateTime.current
        match.status = LOSE
        user.streak = 0
        user.losses += 1
        user.save!
        match.save!
        status = LOSE
      end
    end

  end
end
