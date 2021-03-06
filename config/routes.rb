Rails.application.routes.draw do
  filter :client

  root 'welcome#index'

  get 'example', to: 'welcome#example', as: 'example'

  resources :leagues do
    get 'admin'
    get 'admin/:user_id/toggle', to: 'leagues#create_admin', as: 'admin_toggle'

    get 'players'

    resources :invites, only: [:new, :create]
    get 'invite/generate', to: 'invites#generate', as: 'generate_invite'
    get 'join/:token', to: 'invites#join', as: 'join'
    post 'invite/friend', to: 'invites#friend'

    resources :seasons do
      resources :games, only: [:show, :create]
    end

#    resources :tournaments, only: [:index]
  end

  get 'invite', to: 'invites#general_new', as: 'invite'

  get 'games/new', to: 'games#new', as: 'new_game'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :edit, :update] do
    resources :avatar, only: [:show]
    post 'avatar', to: 'avatars#create', as: 'avatar_create'
  end

  get 'gods', to: 'gods#index', as: 'god'

  get 'ratings/leagues', to: 'ratings#leagues', as: 'league_ratings'
  get 'ratings/seasons', to: 'ratings#seasons', as: 'season_ratings'
end
