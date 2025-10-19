Rails.application.routes.draw do
  
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/update'
  end
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 会員側のルーティング設定
  delete 'cart_items/destroy_all' => 'public/cart_items#destroy_all'
  post 'orders/confirm' => 'public/orders#confirm'
  get 'orders/thanks' => 'public/orders#thanks'

  scope module: :public do
    resources :cart_items, only: [:index,:update,:destroy,:create]
    resources :orders, only: [:new,:create,:index,:show]
  end
  # 管理者側のルーティング設定
  namespace :admin do
    root to: "homes#top" #top = 注文履歴一覧
    resources :customers, only: [:index, :show]
    resources :orders, only: [:show,:update]
    resources :order_details, only: [:update]
  end
end