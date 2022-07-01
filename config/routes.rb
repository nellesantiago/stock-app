Rails.application.routes.draw do
  resources :transactions
  devise_scope :user do
    root 'devise/sessions#new'
  end
  devise_for :users
  resources :stocks, only: %i[index show]
  resources :user_stocks, only: %i[index show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
