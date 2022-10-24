# frozen_string_literal: true

class Match < ApplicationRecord
  enum mode: { basic: 1, scientific: 2, speed: 3, custom: 4 }

  belongs_to :word
  belongs_to :user
  has_many :attempts

  validates :mode, presence: true
end
