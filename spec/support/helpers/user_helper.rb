# frozen_string_literal: true

module UserHelper
  def jwt_encode(payload, expires_at = 1.days.from_now)
    payload[:expires_at] = expires_at.to_i
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
