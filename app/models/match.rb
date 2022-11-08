# frozen_string_literal: true

class Match < ApplicationRecord
  MAX_ATTEMPTS = 6

  enum mode: { basic: 1, scientific: 2, speed: 3, custom: 4 }
  enum status: { playing: 0, win: 1, lose: 2 }

  belongs_to :word
  belongs_to :user

  has_many :attempts, before_add: :validate_attempts_count

  validates :mode, presence: true
  validates :status, presence: true

  def update_win!
    self.finished_at = DateTime.current
    self.status = 1
    self.save!
  end

  def update_lose!
    self.finished_at = DateTime.current
    self.status = 2
    self.save!
  end

  private

  def validate_attempts_count(attempt)
    attempt.count = attempts.count + 1

    if attempt.count > MAX_ATTEMPTS
      attempt.errors.add(:base, I18n.t('models.match.attempts.errors.count'))
      throw(:abort)
    end
  end
end
