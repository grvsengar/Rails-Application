Rails.application.routes.draw do
  get 'homes/index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  #friendrequest controller
  # resources :users, only: [] do
  #   member do
  #     post 'send_request', to: 'friend_requests#send_request', as: :send_request_friend_request
  #     post 'accept_request', to: 'friend_requests#accept_request', as: :accept_request_friend_request
  #   end
  # end
  
  resources :posts
  # resources :friend_request
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  #user controller
  resources :users, only: [:index, :show] do
    member do
      post 'send_request', to: 'friend_requests#send_request', as: :send_request_friend_request
      post 'accept_request', to: 'friend_requests#accept_request', as: :accept_request_friend_request
    end
  end
  
  
  
# Analytics and Activities routes
namespace :admin do
  resources :analytics, only: [:index]
end
resources :activities, only: [:index]

# SuperAdmin routes
namespace :admin do
  resources :superadmin, only: [:index, :show, :update]
end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
   root "homes#index"
end
