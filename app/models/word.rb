# frozen_string_literal: true

class Word < ApplicationRecord
  validate :length_fits_kind, :on => :create

  has_many :match_words
  has_many :matches, through: :match_words

  validates :value, presence: true, uniqueness: true, length: {minimum: 5, maximum: 7}
  validates :kind, presence: true,
    :inclusion=> { :in => ["normal", "scientific", "create"] }

  private

  def length_fits_kind
    return errors.add("\'normal\' kind of words must be only 5 characters long") if(self.kind == "normal" && self.value.length != 5)

    return errors.add("\'scientific\' kind of words must be only 7 characters long") if (self.kind == "scientific" && self.value.length != 7)
  end

end
