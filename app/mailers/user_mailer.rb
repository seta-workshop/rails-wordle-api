# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'agustin@setaworkshop.com'

  def send_confirmation_email(user)
    @user = user

    mail(
      to: @user.unconfirmed_email,
      subject: "WORDLE-API EMAIL CONFIRMATION"
    )
  end

  def send_change_password(user)
    @user = user

    mail(
      to: @user.email,
      subject: "WORDLE-API PASSWORD CHANGE"
    )
  end

  def reset_password_email(user)
    @user = user

    mail(
      to: @user.email,
      subject: 'WORDLE-API PASSWORD CHANGE'
    )
  end

  def reset_email_email(user)
    @user = user

    mail(
      to: @user.email,
      subject: 'WORDLE-API EMAIL CHANGE'
    )
  end
end
