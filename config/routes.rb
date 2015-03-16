Rails.application.routes.draw do
    root 'welcome#index'

    resources :leagues
    resources :seasons
end
