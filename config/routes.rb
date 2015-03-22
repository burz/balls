Rails.application.routes.draw do
  root 'welcome#index'

  resources :leagues, only: [:show, :index, :new, :create] do
    get 'admin'
    get 'admin/:user_id/toggle', to: 'leagues#create_admin', as: 'admin_toggle'
    get 'players'
    resources :invites, only: [:new, :create]
    get 'join/:token', to: 'invites#join', as: 'join'
    resources :seasons, only: [:show, :index, :new, :create] do
      resources :games, only: [:show, :create]
    end
  end

  devise_for :users
  resources :users, only: [:show] do
    post 'avatar'
  end
end
