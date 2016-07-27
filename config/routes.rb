Rails.application.routes.draw do

  get 'courses/index'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'users#index'

  get 'maps' => 'maps#index'
  
  get 'library' => 'library#index'
  match '/reserved_book' => 'library#reserved_book', :via => :post

  get 'welcome' => 'welcome#home'

  get '/signup'  => 'users#new'

  get 'admin' => 'users#admin'
  resources :users

  get 'maps/burnaby'
  get 'maps/surrey'
  get 'maps/vancouver'

  resources :maps
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  resources :sessions
  resources :messages do
  resources :comments
  resources :users
  end

  get 'transit/index'
  resources :transit

  # Api definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/'  do
    # We are going to list our resources here
  end


end
