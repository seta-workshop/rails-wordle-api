
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

      ServiceResult.new(messages: [I18n.t('global.success')])
    end

    private
    attr_reader :match, :params

    def user
      @user ||= match.user
    end

    def word
      @word ||= params[:word].downcase
    end

    def match_word
      @match_word ||= match.word.value.downcase
    end

    def update_match_and_attempts
      byebug
      return match.update_win! if word == match_word
      if match.attempts.count >= 5
        match.update_lose!
      end
    end

  end
end