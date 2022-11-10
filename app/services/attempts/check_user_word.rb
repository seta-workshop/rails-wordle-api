# frozen_string_literal: true

module Attempts
  class CheckUserWord < Service

    def initialize(params: )
      @user_attempt_word = params[:word]
    end

    def call
      raise I18n.t('services.attempts.check_user_word.errors') unless exists_on_dictionary?

      return ServiceResult.new(messages: [I18n.t('global.success')])
    end


    private

    attr_reader :params

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
  end
end
