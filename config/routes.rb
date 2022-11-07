# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post 'api/v1/auth/login', to: 'api/v1/authentication#login'



  resources(:passwords, only: [:update], param: :token) do
    post 'forgot', to: 'passwords#create', on: :collection
  end


  namespace :api do
    namespace :v1 do
      resources(:matches, only: [:create])
      resources(:users, only: %i[index, create])
      resources(:emails, only: [:create, :update], param: :token)

      resources(:matches, only: [:create]) do
        post :attempts, to: 'matches/attempts#create'
      end

    end
  end
end
