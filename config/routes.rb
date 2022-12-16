Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'

  resources :posts, only: [:index, :show, :new, :create, :edit, :update] do
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :categories, only: [:new, :create]

end
