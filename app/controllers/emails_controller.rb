# frozen_string_literal: true

class EmailsController < ApplicationController
  skip_before_action :authenticate_request, only: [:update]

  def create
    result = Users::EmailUpdate.call(params: params)
    if result.success?
      render(json: { messages: result.messages, status: :ok })
    else
      render(json: { errors: result.errors }, status: :bad_request)
    end
  end

  def update
    result = Users::ChangeEmail.call(params: params)
    result.success? ? render(json: {messages: result.messages}, status: :ok)
    : render(json: { errors: result.errors }, status: :bad_request)
  end
end
