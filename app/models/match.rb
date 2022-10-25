# frozen_string_literal: true

class Match < ApplicationRecord
  MAX_ATTEMPTS = 6

  enum mode: { basic: 1, scientific: 2, speed: 3, custom: 4 }

  belongs_to :word
  belongs_to :user

  has_many :attempts, before_add: :validate_attempts_count

  validates :mode, presence: true

  private

  def validate_attempts_count(attempt)
    attempt.count = attempts.count + 1

    if attempt.count > MAX_ATTEMPTS
      attempt.errors.add(:base, 'Max attempts reached')
      throw(:abort)
    end
  end
end
