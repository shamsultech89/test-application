Rails.application.routes.draw do
  resources :github_users
  namespace :api do
    resources :sessions, only: [:create]
  end
  resources :users
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
