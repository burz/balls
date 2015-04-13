Rails.application.routes.draw do
  filter :client

  root 'welcome#index'

  get 'example', to: 'welcome#example', as: 'example'

  resources :leagues, only: [:show, :index, :new, :create, :edit, :update] do
    get 'admin'
    get 'admin/:user_id/toggle', to: 'leagues#create_admin', as: 'admin_toggle'
    get 'players'
    resources :invites, only: [:new, :create]
    get 'join/:token', to: 'invites#join', as: 'join'
    resources :seasons, only: [:show, :index, :new, :create, :edit, :update] do
      resources :games, only: [:show, :create]
    end
  end

  get 'invite', to: 'invites#general_new', as: 'invite'

  get 'games/new', to: 'games#new', as: 'new_game'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :edit, :update] do
    resources :avatar, only: [:show]
    post 'avatar', to: 'avatars#create', as: 'avatar_create'
  end

  get 'god', to: 'gods#index', as: 'god'

  get 'ratings/leagues', to: 'ratings#leagues', as: 'league_ratings'
  get 'ratings/seasons', to: 'ratings#seasons', as: 'season_ratings'
end
