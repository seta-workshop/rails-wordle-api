# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/auth/login', to: 'authentication#login'

  resources(:users, only: %i[index, create])

  resources(:passwords, only: [:update], param: :token) do
    post 'forgot', to: 'passwords#create', on: :collection
  end

  resources(:emails, only: [:create, :update], param: :token)

  resources(:matches, only: [:create]) do
    resources(:attempts, only: [:create])
  end
end
