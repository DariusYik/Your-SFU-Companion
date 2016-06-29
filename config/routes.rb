Rails.application.routes.draw do


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'users#index'

  get 'welcome' => 'welcome#home'

  get '/signup'  => 'users#new'

  get 'admin' => 'users#admin'
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  resources :sessions
  resources :messages do
  resources :comments
  resources :users
  end

  # Api definition
  namespace :api do
    # We are going to list our resources here
  end


end
