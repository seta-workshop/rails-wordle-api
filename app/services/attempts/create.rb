# frozen_string_literal: true

module Attempts
  class Create < Service
    def initialize(match:, params:)
      @match = match
      @params = params
    end

    def call
      return ServiceResult.new(errors:['Only 5 characters are supported in basic mode']) if basic?
      return ServiceResult.new(errors:['Only 7 characters are supported in scientific mode']) if scientific?
      return ServiceResult.new(messages:['You lose. Match has finished.']) if has_lost?
      return ServiceResult.new(messages:['You win. Match has finished.']) if has_won?

      check_answer

      ServiceResult.new(
        object: attempt,
        messages:["Attempt: #{attempt.count}, Match: #{match.id}"],
        errors: attempt.errors.full_messages
      )
    end

    private

    attr_reader :match, :params

    def letters
      @letters ||= params[:word].split('')
    end

    alias_method :letters_colours, :letters

    def attempt
      @attempt ||= match.attempts.create!(
        user_id: match.user_id,
        letters: letters,
        letters_colours: letters_colours
      )
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

    def check_answer
      if params[:word] == (match.word.value)
        match.finished_at = DateTime.current
        match.status = 1
        match.save!
      else
        if match.attempts.count == 5
          match.finished_at = DateTime.current
          match.status = 2
          match.save!
        end
      end
    end

  end
end
