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

    get 'chats', to: 'chats#index', as: 'chats'
    get 'chat/:id', to: 'chats#show', as: 'chat'
    post 'chat/:id/messages', to: 'messages#create', as: 'chat_messages'
    post 'chat/:id', to: 'chats#create', as: 'chat_create'
  end
end
