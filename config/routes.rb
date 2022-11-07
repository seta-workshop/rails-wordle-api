# frozen_string_literal: true

Rails.application.routes.draw do
  post 'api/v1/auth/login', to: 'api/v1/authentication#login'

  namespace :api do
    namespace :v1 do
      resources(:matches, only: [:create])
      resources(:users, only: %i[index, create])
      resources(:emails, only: [:create, :update], param: :token)
      resources(:passwords, only: [:update], param: :token) do
        post 'forgot', to: 'passwords#create', on: :collection
      end

      resources(:matches, only: [:create]) do
        post :attempts, to: 'matches/attempts#create'
      end
    end
  end
end
