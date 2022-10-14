# frozen_string_literal: true

class Word < ApplicationRecord
  enum kind: { basic: 1, scientific: 2, custom: 4 }

  validate :length_fits_kind, on: :create

  has_many :match_words
  has_many :matches, through: :match_words

  validates :value, presence: true, uniqueness: true, length: {minimum: 5, maximum: 7}
  validates :kind, presence: true

  private

  def length_fits_kind
    if self.kind == 'basic' && self.value.length != 5
      return errors.add("\'basic\' kind of words must be only 5 characters long")

    elsif self.kind == 'scientific' && self.value.length != 7
      return errors.add("\'scientific\' kind of words must be only 7 characters long")

    end
  end

end
