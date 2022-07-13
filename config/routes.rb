Rails.application.routes.draw do
  root 'stocks#home'
  get 'dashboard', to: 'dashboard#index', as: "dashboard"
  devise_for :users, :path_prefix => 'devise'
  
  resources :users
  resources :stocks, only: %i[index]
  resources :user_stocks, only: %i[index]
  resources :transactions, only: %i[index new create]

  namespace :admin do
    resources :transactions, only: %i[index]
  end


  namespace :balance do
    get 'top-up', action: :edit
    patch 'top-up', action: :update
    put 'top-up', action: :update
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
