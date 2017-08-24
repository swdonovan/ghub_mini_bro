Rails.application.routes.draw do
  root 'home#index'

  post 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  resources :user, only: [:show] do
    resources :dashboards, only: [:index]
  end

  get '/auth/github', as: :github_login
  get '/auth/github/callback', to: 'sessions#create'


end
