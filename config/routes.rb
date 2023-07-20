# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'dashboard#show'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  post '/signup', to: 'registration#create'
  get '/signup', to: 'registration#new'
  get '/confirm/:signed_id/:token', to: 'registration#confirm'

  resource :profile
end
