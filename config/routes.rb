Rails.application.routes.draw do
  root 'home#show'

  resources :profile, only: %i[show destroy]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
