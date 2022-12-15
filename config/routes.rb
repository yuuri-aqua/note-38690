Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'

  resources :posts, only: [:index, :new, :create]
  resources :categories, only: [:new, :create]
end
