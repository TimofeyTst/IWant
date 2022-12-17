Rails.application.routes.draw do
  root 'posts#index'

  # GET search/index
  get 'search', to: 'search#index'

  # POST like_comment_path(comment)
  post 'like/id', to: 'comments#like', as: 'like_comment'

  # Profile paths
  get 'profile/:id', to: 'profile#show', as: 'profile'
  delete 'profile/avatar', to: 'profile#destroy_avatar'

  post 'profile/follow', to: 'profile#follow'
  delete 'profile/unfollow', to: 'profile#unfollow'
  get 'profile/:id/followers', to: 'profile#followers', as: 'profile_followers'
  get 'profile/:id/followees', to: 'profile#followees', as: 'profile_followees'
  put 'profile/:id/theme', to: 'profile#theme', as: 'profile_theme'

  get 'albums', to: 'interests#show', as: 'albums'
  get 'interests/saved'
  post 'interests/save'
  delete 'interests/unsave'


  devise_for :users
  devise_scope :user do
    get 'users', to: 'devise/sessions#new'
  end

  resources :posts do
    resources :comments
  end

  resources :rooms, only: %i[index show create] do
    resources :messages
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
