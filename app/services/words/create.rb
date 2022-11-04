# frozen_string_literal: true

module Words
  class Create < Service
    def initialize(kind:)
      @kind = kind
    end

    def call
      ServiceResult.new(object: word, messages:[I18n.t('services.words.create.current_word')])
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
      lines = []

      file.each_line do |line|
        value = line[0..4]
        lines.push(value)
      end
      file.close

      rand_word_index = rand(0..lines.length)
      rand_word = lines.values_at(rand_word_index).to_sentence.downcase
      created = false
      while !created
        if !Word.find_by(value: rand_word)
          created = true
          return Word.create(kind:'basic', value: rand_word)
        end
      end

    end
  end
end
