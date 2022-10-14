# frozen_string_literal: true

class User < ApplicationRecord
  require "securerandom"
  has_secure_password

  has_many :matches

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }


  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  def generate_email_token!
    self.reset_email_token = generate_token
    self.reset_email_sent_at = Time.now.utc
    save!
  end

  def email_token_valid?
    (self.reset_email_sent_at + 4.hours) > Time.now.utc
  end

  def new_email_update!(email)
    self.unconfirmed_email = email
    save!
  end

  def change_email!
    self.email = self.unconfirmed_email
    self.unconfirmed_email = nil
    save
  end

  def self.email_used?(email)
    existing_user = find_by("email = ?", email)

    if existing_user.present?
      return true
    else
      waiting_for_confirmation = find_by("unconfirmed_email = ?", email)
      return waiting_for_confirmation.present? && waiting_for_confirmation.email_token_valid?
    end
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

end
