# frozen_string_literal: true

class Attempt < ApplicationRecord

  belongs_to :user
  belongs_to :match

  validates :count, length: { minimum: 0, maximum:6 }
  validates :letters, length: { minimum: 5, maximum:7 }
  validates :letters_colours, length: { minimum: 5, maximum:7 }
end
