# frozen_string_literal: true

module Attempts
  class CreateCandidate < Service
    def initialize(match:, params:)
      @match = match
      @params = params
    end

    def call
      return ServiceResult.new(messages:[I18n.t('services.attempts.create.match_lost')]) if has_lost?
      return ServiceResult.new(messages:[I18n.t('services.attempts.create.match_won')]) if has_won?

      raise StandardError.new(I18n.t 'services.attempts.create.basic_mode_characters') if basic?
      raise StandardError.new(I18n.t 'services.attempts.create.scientific_mode_characters') if scientific?
      raise StandardError.new(I18n.t('services.attempts.check_user_word.errors')) unless check_attempt_answer.success?

      ServiceResult.new(
        object: {
          attempt_count: match.attempts.count,
          attempt_answer: match_word,
          typed_word: word,
          letters_colours: attempt,
          match_status: match.status,
        }
      )
    end

    private

    attr_reader :match, :params

    def word
      @word ||= params[:word].downcase

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
      100.times do
        match.lose?
      end
    end

    def check_attempt_answer
      result = Attempts::CheckAnswer.call(match: match, params: params)
      return ServiceResult.new(errors:[result.errors]) unless result.success?

      result
    end
  end
end
