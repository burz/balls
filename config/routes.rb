Rails.application.routes.draw do
  root 'welcome#index'

  resources :leagues do
    get 'admin'
    get 'players'
    get 'invite'
    post 'send', to: 'leagues#send_invite', as: 'send_invite'
    get 'join/:token', to: 'leagues#join', as: 'join'
    resources :seasons do
      resources :games
    end
  end

  devise_for :users
  resources :users
end
