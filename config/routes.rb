Rails.application.routes.draw do

  root "videos#index"
  resources :videos do
    resources :requests
  end
  resources :payments, only:[:new,:create]


#Users###################################################
  # It will list all users account
  get "/users" => "users#index", as: :users

  # It will show a form to create a new User account.
  get "/users/new" => "users#new", as: :new_user
  post "/users" => "users#create" # It will save User in DB.
  # It will show an user account
  get "/users/:id" => "users#show", as: :user

  # It will edit an account information
  get "/users/:id/edit" => "users#edit", as: :edit_user
  patch "/users/:id" => "users#update"

  # It will delete an account
  delete "/users/:id" => "users#destroy"
#############################################################
#requests######################################################

  # get "/users/:user_id/requests/:id" => "requests#show"
  get   "/users/:user_id/requests" => "requests#index", as: :users_requests
  get   "/users/:user_id/requests/new" => "requests#new",as: :new_user_request
  patch "/users/:user_id/requests/:id" => "requests#update", as: :update_user_request
  post  "/users/:user_id/requests" => "requests#create"

############################################################
  # Resources of sessions
  delete "/logout" => "sessions#destroy", as: :logout
  resources :sessions, only: [:new, :create]

end
