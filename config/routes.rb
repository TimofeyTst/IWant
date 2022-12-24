Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root 'posts#index'

    # GET search/index
    get 'search', to: 'search#index'

    # POST like_comment_path(comment)
    post 'like/id', to: 'comments#like', as: 'like_comment'

    # Profile paths
    get 'profile/:id', to: 'profile#show', as: 'profile'
    delete 'profile/avatar', to: 'profile#destroy_avatar'

    post 'profile/:id/follow', to: 'profile#follow', as: 'profile_follow'
    delete 'profile/:id/unfollow', to: 'profile#unfollow', as: 'profile_unfollow'
    get 'profile/:id/followers', to: 'profile#followers', as: 'profile_followers'
    get 'profile/:id/following', to: 'profile#following', as: 'profile_following'

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
      resources :comments, only: %i[create destroy]
    end

    resources :rooms, only: :show do
      resources :messages, only: :create
    end
    get 'chats', to: 'rooms#index', as: 'chats'
    get 'chat/:id', to: 'rooms#show', as: 'chat'
    post 'chat/:id', to: 'rooms#create', as: 'chat_create'
  end
end
