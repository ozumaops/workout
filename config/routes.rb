Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # config/routes.rb
  get '/auth/:provider/callback', to: 'sessions#create'


  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
end