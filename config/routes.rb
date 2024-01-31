# frozen_string_literal: true

Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'home#index'

  # get '/home/:id' => 'homes#show'
  post '/tweet/:id' => 'tweets#create'
  get '/tweet' => 'tweets#new'
  post '/favorite/:id' => 'favorites#create'

  resources :home, only: %i[index show]
  resources :tweets, only: %i[create new destroy]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
