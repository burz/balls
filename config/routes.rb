Rails.application.routes.draw do
  root 'welcome#index'

  resources :leagues do
    get 'admin'
    get 'players'
    resources :seasons do
      resources :games
    end
  end

  devise_for :users
  resources :users
end
