# frozen_string_literal: true

module Words
  class Create < Service
    def initialize()
    end

    def call
      ServiceResult.new(object: word, messages:['Current word'])
    end

    private
    attr_reader :params

    def word
      range = (DateTime.now.beginning_of_day..DateTime.now.end_of_day)
      return Word.find_or_create_by!(created_at: range, kind: 'basic', value: 'siete')
    end

  end
end
