# frozen_string_literal: true

class Word < ApplicationRecord
  enum kind: { basic: 1, scientific: 2, custom: 4 }

  validate :length_fits_kind, on: :create

  # validates :kind, inclusion: { in: kinds.keys, message: "Kind is not valid.\n Valid values: basic, scientific and custom" }

  validates :value, presence: true, uniqueness: true, length: {minimum: 5, maximum: 7}

  private

  def length_fits_kind
    if self.basic? && self.value.length != 5
      return errors.add(:kind, '\'basic\' kind of words must be only 5 characters long')

    elsif self.scientific? && self.value.length != 7
      return errors.add(:kind, '\'scientific\' kind of words must be only 7 characters long')
    end
  end

end
