Rails.application.routes.draw do
  get "profiles/index"
  # get "likes/create"
  # get "likes/destroy"
  # get "likes/like_params"
  resources :likes, only: [ :create, :destroy ]
  resources :comments


  devise_scope :user do
    get "/users", to: "devise/registrations#new"
    get "/users/password", to: "devise/passwords#new"
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :posts do
    resources :comments, only: [ :create, :destroy ]  # Add nested comments routes
  end

  # devise_for :users
  get "home/about"
  get "posts/myposts"

  resources :users, only: [ :show ]

  # Defines the root path route ("/")
  root "posts#index"
end
