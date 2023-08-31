Rails.application.routes.draw do
  devise_for :users
 
  root "conversations#index"

  resources :conversations, only: [:index]
  resources :messages, only: [:create]

end
