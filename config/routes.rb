Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :recipes, only: [:show, :new, :create, :edit, :update, :index] do
    collection do
      get 'search'
      get 'by_user'
      get 'favorites'
    end
    member do
      post 'favorite'
    end

  end
  resources :cuisines, only: [:show, :new, :create, :edit, :update]
  resources :recipe_types, only: [:show, :new, :create]
end
