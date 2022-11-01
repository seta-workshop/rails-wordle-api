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

      ServiceResult.new(object: { attempt: check_attempt_answer, letters_colours: attempt })
    end

    private

    attr_reader :match, :params

    def letters
      @letters ||= params[:word].split('')
    end

    def attempt
      @attempt = match.attempts.create!(
        user_id: match.user_id,
        letters: letters,
        letters_colours: letters_colours
      )
    end

    def letters_colours
      word = Word.find(match.word_id).value
      try = params[:word]
      result = Attempts::Colors.call(word: word, try: try).object[:result]

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
      result = Attempts::CheckAnswer.call(match: match, params: params).object

      result
    end

  end
end
