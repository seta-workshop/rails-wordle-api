# frozen_string_literal: true

module Matches
  class Create < Service
    def initialize(params:, user:)
      @params = params
      @user = user
    end

    def call
      return ServiceResult.new(errors: ['User not present']) unless @user

      user_has_match
    end

    private

    attr_reader :params

    def user_has_match
      match = Match.find_or_create_by(user_id: @user.id) do |m|
        m.user_id = @user.id
        m.word_id = Word.last.id
        m.mode = 'basic'
      end
      ServiceResult.new(object: match, messages:['Current match'])
    end
  end
end
