# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'dashboard#index'

  get '/signin', to: 'sessions#new', as: 'signin'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  post '/signup', to: 'users#create'
  get '/signup', to: 'users#new'
end
