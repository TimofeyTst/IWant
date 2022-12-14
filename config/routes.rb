Rails.application.routes.draw do
  root 'posts#index'
  get 'home/show'

  # GET search/index
  get 'search', to: 'search#index'

  # POST like_comment_path(comment)
  post 'like/id', to: 'comments#like', as: 'like_comment'

  get 'profile/:id', to: 'profile#show', as: 'profile'
  post 'profile/follow', to: 'profile#follow'
  delete 'profile/unfollow', to: 'profile#unfollow'
  delete 'profile/avatar', to: 'profile#destroy_avatar'

  devise_for :users

  resources :posts do
    resources :comments
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
