Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'

  resources :posts, only: [:index, :new, :create, :edit, :update]
  resources :categories, only: [:new, :create]
end
