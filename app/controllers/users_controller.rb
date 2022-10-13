# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  # before_action :validate_email_update, only: [:show, :destroy, :update]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: {errors: @user.errors.messages},
      status: :unprocessable_entity
    end
  end

  def update
    unless @user.update(user_params)
      render json: {errors: @user.errors.messages},
      status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password, :token)
  end

  def validate_email_update
    result = Users::ValidateEmailUpdate.call(current_user: @current_user, params: params)
    render(json: { error: result.errors }) unless result.success?
  end
end
