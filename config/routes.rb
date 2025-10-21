Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 【ウッチャン追加】ネスト未設定
  ## 会員側のルーティング設定
  delete 'cart_items/destroy_all' => 'public/cart_items#destroy_all'
  post 'orders/confirm' => 'public/orders#confirm'
  get 'orders/thanks' => 'public/orders#thanks'

  scope module: :public do
    # マイページ
    get "customers/my_page" => "customers#show"
    # 退会
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    
    resources :cart_items, only: [:index,:update,:destroy,:create] do
      delete 'destroy_all', on: :collection
   end
    resources :orders, only: [:new,:create,:index,:show]
  end
  ## 管理者側のルーティング設定
  namespace :admin do
    root to: "homes#top" #top = 注文履歴一覧
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show,:update]
    resources :order_details, only: [:update]
  end
  # 【ウッチャン追加】ネスト未設定
end