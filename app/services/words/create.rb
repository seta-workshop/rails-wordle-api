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
      range = (DateTime.now..DateTime.now.end_of_day)
      word = Word.where(created_at: range)
      if word.empty?
        word = Word.create(kind:'basic', value: Faker::Lorem.characters(number: 5))
      end
      return word
    end

  end
end
