# frozen_string_literal: true

class AttemptsController < ApplicationController

  def create
    match =
    result = Attempts::Create.call(user: @current_user)

  end

end
