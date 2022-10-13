# frozen_string_literal: true

class Match < ApplicationRecord
  has_many :match_words
  has_many :words, through: :match_words
end
