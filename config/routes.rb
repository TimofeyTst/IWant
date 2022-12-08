Rails.application.routes.draw do
  root 'home#show'

  get 'session/new'
  post 'session/create'
  delete 'session/destroy'

  resources :users, only: %i[new create destroy edit update show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
