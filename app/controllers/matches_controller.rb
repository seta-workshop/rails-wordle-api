# frozen_string_literal: true

class MatchesController < ApplicationController
  def create
    result = Matches::Create.call(params: params, user: @current_user)
    if result.success?
      render(json: { object: result.object, messages:result.messages, status: :ok })
    else
      render(json: { errors:result.errors, status: :bad_request })
    end
  end
end
