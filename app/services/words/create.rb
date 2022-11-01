# frozen_string_literal: true

module Words
  class Create < Service
    def initialize(kind:)
      @kind = kind
    end

    def call
      ServiceResult.new(object: word, messages:['Current word'])
    end

    private
    attr_reader :kind

    def word
      range = (Time.current.beginning_of_day..Time.current.end_of_day)

      Word.find_by(kind: kind, created_at: range) || generate_from_dictionary
    end

    def generate_from_dictionary
      path = File.join(Rails.root, 'lib', 'files','words.txt')
      file = File.open(path, "r")

      file.each_line do |line|
        value = line[0..4]
        created = false

        if !Word.find_by(value: value)
          return Word.create(kind:'basic', value: value)
        end
      end
      f.close
    end

  end
end
