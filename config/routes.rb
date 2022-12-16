Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'

  resources :posts, only: [:index, :show, :new, :create] do
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :categories, only: [:new, :create]

end
