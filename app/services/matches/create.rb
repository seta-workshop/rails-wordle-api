# frozen_string_literal: true

module Matches
  class Create < Service
    def initialize(params:, user:)
      @params = params
      @user = user
    end

    def call
      return ServiceResult.new(errors: ['User not present']) unless user
      return word_result unless !word_result.success?

      ServiceResult.new(object: match!, messages:['Current match'])
    end

    private

    attr_reader :params, :user

    def find_or_create_match!
      user.matches.find_or_create_by!(word_id: word.id, mode: 'basic')
    end

    alias_method :match, :find_or_create_match!

    def word_result
      @word_result ||= Words::Create.call(kind: params[:mode])
    end

    def word
      word_result.object
    end
  end
end
