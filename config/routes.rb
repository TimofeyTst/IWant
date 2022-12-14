Rails.application.routes.draw do
  root 'posts#index'
  get 'home/show'
  get 'search', to: 'search#index'

  # like_comment_path(comment)
  post 'like/id', to: "comments#like", as: "like_comment"

  resources :profile, only: %i[show destroy]
  devise_for :users
  resources :posts do
    resources :comments
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
