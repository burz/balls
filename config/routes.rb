Rails.application.routes.draw do
  root 'welcome#index'

  resources :leagues do
    resources :seasons
  end

  devise_for :users
  resources :users
end
