Rails.application.routes.draw do
  devise_for :users
root to: 'items#index'
resources :users, only: [:edit, :update]
resources :items, only: [:new, :create, :edit, :destroy, :show, :index, :update]
end
