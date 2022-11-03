# frozen_string_literal: true

module Attempts
  class Create < Service
    def initialize(match:, params:)
      @match = match
      @params = params
    end

    def call
      return ServiceResult.new(messages:['You lose. Match has finished.']) if has_lost?
      return ServiceResult.new(messages:['You win. Match has finished.']) if has_won?
      return ServiceResult.new(errors:['Only 5 characters are supported in basic mode']) if basic?
      return ServiceResult.new(errors:['Only 7 characters are supported in scientific mode']) if scientific?
      check_attempt_answer

      ServiceResult.new(object: { attempt_count: match.attempts.count, attempt_answer: match_word, typed_word: word, letters_colours: attempt, match_status: match.status})
    end

    private

    attr_reader :match, :params

    def word
      @word ||= params[:word].downcase
    end

    def match_word
      @match_word ||= match.word.value.downcase
    end

    def letters
      @letters ||= params[:word].split('')
    end

    def attempt
      @attempt = match.attempts.create!(
        user_id: match.user_id,
        letters: letters,
        letters_colours: letters_colours.object
      )

      letters_colours.object
    end

    def letters_colours
      result = Attempts::Colors.call(word: match_word, try: word)
      return ServiceResult.new(errors:[result.errors]) unless result.success?

      result
    end

    def basic?
      match.basic? && letters.length != 5
    end

    def scientific?
      match.scientific? && letters.length != 7
    end

    def has_won?
      match.win?
    end

    def has_lost?
      match.lose?
    end

    def check_attempt_answer
      result = Attempts::CheckAnswer.call(match: match, params: params)
      return ServiceResult.new(errors:[result.errors]) unless result.success?

      result
    end
  end
end
