# frozen_string_literal: true

module Matches
  class Create < Service
    def initialize(params:, user:)
      @params = params
      @user = user
    end

    def call
      return ServiceResult.new(errors: ['User not present']) unless user

      ServiceResult.new(object: match!, messages:['Current match'])
    end

    private

    attr_reader :params, :user

    def match!
      user.matches.find_or_create_by!(word_id: word!.id, mode: 'basic')
    end

    def word!
      word_result ||= Words::Create.call
      return word_result.object unless !word_result.success?
    end
  end
end
