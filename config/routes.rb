# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'home#index'

  # get '/home/:id' => 'homes#show'
  post '/tweet/:id' => 'tweets#create'
  post '/reply/:id' => 'replies#create'
  get '/tweet' => 'tweets#new'
  get '/tweet/:id' => 'tweets#show'
  # post '/favorite/:id' => 'favorites#create'

  resources :home, only: %i[index show]
  resources :tweets, only: %i[create new destroy show]
  resources :favorites, only: :create
  resources :bookmarks, only: %i[index create]
  resources :retweets, only: :create

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
