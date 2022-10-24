# frozen_string_literal: true

module Matches
  class Create < Service
    def initialize(params:, user:)
      @params = params
      @user = user
    end

    def call
      return ServiceResult.new(errors: ['User not present']) unless user

      ServiceResult.new(object: match, messages:['Current match'])
    end

    private

    attr_reader :params, :user

    def match
      user.matches.find_or_create_by!(word_id: Words::Create.call.object.id, mode: 'basic')
    end
  end
end
