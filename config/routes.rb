Rails.application.routes.draw do
  resources :auth, only: [:create]
  resources :dashboard, only: [:index]
end
