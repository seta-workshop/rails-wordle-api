# frozen_string_literal: true

module Attempts
  class CheckAnswer < Service
    PLAYING = 0
    WIN = 1
    LOSE = 2

    def initialize(match: ,params:)
      @match = match
      @params = params
      @user_attempt_word = params[:word]
    end

    def call
      return ServiceResult.new(errors: I18n.t('services.attempts.check_user_word.errors')) unless exists_on_dictionary?
      update_match_and_attempts!

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

    def exists_on_dictionary?
      path = File.join(Rails.root, 'lib', 'files','words.txt')
      file = File.open(path, "r")
      lines = []

      file.each_line do |line|
        value = line[0..4]
        lines.push(value.downcase)
      end
      file.close

      lines.include?(@user_attempt_word)
    end

    def update_match_and_attempts!
      if word == match_word
        match.win!
      elsif match.attempts.count >= Match::MAX_ATTEMPTS
        match.lose!
      end
    end
  end
end
