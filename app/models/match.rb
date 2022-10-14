# frozen_string_literal: true

class Match < ApplicationRecord
  enum mode: { basic: 1, scientific: 2, speed: 3, custom: 4 }

  belongs_to :user
  belongs_to :word # palabra del dia que tiene que adivinar el usuario

  validates :mode, presence: true
end
