Rails.application.routes.draw do
  devise_for :users
 
  root "conversations#index"

  resources :conversations, only: [:new, :index]
  resources :messages, only: [:create]

end
