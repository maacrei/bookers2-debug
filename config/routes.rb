Rails.application.routes.draw do

  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search"=>"searches#search"

  get "search_book" => "books#search_book"
  # get "search_book" => "searches#search_book"

  # get 'chats/show'
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'search' => 'users#search'
    # 上記追加
  end

  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
  end

end