# frozen_string_literal: true

module Words
  class Create < Service
    def initialize()
    end

    def call
      ServiceResult.new(object: word!, messages:['Current word'])
    end

    private
    attr_reader :params

    def word!
      range = (Time.current.beginning_of_day..Time.current.end_of_day)
      return Word.find_by(created_at: range) || Word.create!(kind:'basic', value: 'siete')
    end

  end
end
