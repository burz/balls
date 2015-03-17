Rails.application.routes.draw do
  root 'welcome#index'

  resources :leagues do
    get 'admin'
    resources :seasons
  end

  devise_for :users
  resources :users
end
