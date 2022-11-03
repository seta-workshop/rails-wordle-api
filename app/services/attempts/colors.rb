# frozen_string_literal: true

module Attempts
  class Colors < Service
    GREEN = 'green'
    YELLOW = 'yellow'
    GREY = 'grey'
    CHECKED_CHAR = '-'

    def initialize(word:, try:)
      @word = word
      @word_copy = word.dup
      @try = try
      @result = [nil] * word.length
    end

    def call
      green_letters
      yellow_and_grey_letters
      ServiceResult.new(object: result, messages: ['Success'])
    end

    private

    attr_reader :word, :word_copy, :try, :result

    def green_letters
      try.length.times do |i|0
        next unless try[i] == word[i]

        result[i] = GREEN
        word_copy[i] = CHECKED_CHAR
      end
    end

    def yellow_and_grey_letters
      try.length.times do |i|
        next unless result[i].blank?

        if word_copy.include?(try[i])
          result[i] = YELLOW
          word_copy[word_copy.index(try[i])] = CHECKED_CHAR
        else
          result[i] = GREY
        end
      end
    end
  end
end
