Rails.application.routes.draw do


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
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
  

end
