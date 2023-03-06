Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about", as: 'about'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]

  end
  resources :users, only: [:index,:show,:edit,:update]do
   # ネストさせる
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
# do =>end でネストする。ネストとは？親モデル（１：Nの１側）のIDを必要とする場合に使う。
# resource一回しかできないこと（いいね。フォロー）