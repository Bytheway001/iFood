Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get '/notifications' => 'restaurants#notifications'
  get 'home/index'
  post 'orders/confirm'
  get 'orders/cartmodal'
  get 'orders/status/:id' => 'orders#status'
  post 'orders/paymodal'
  get '/dishlist' => 'home#dishlist'

  post '/newingredient'=>"home#ingredient"
  resource :user
  resources :orders
  resources :restaurants
  devise_for :users,controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # Rutas para dueño de restaurant
  namespace :users do
    get 'sales'
    post 'placeorder'
    get 'profile'
    resources :restaurants do
      get 'sales' # users_restaurant_sales_path
      resources :dishes do
      end
    end
    resources :orders do
      get 'ready'
    end
    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
