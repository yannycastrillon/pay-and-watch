Rails.application.routes.draw do

  root "videos#index"
  # get "/videos/inactives" => "videos#inactive_videos"
  resources :videos do
    # get :activate, :on => :member
    get :inactives, :on => :collection
    put :activates, :on => :collection
    resources :requests
  end
  resources :payments, only:[:new,:create]
  # put "/videos/activate" => "videos#activate"


#Users###################################################
  # It will list all users account
  get "/users" => "users#index", as: :users

  # It will show a form to create a new User account.
  get "/users/new" => "users#new", as: :new_user
  post "/users" => "users#create" # It will save User in DB.
  get "/users/:id" => "users#show", as: :user
  get "/users/:id/edit" => "users#edit", as: :edit_user
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

#requests######################################################

  # get "/users/:user_id/requests/:id" => "requests#show"
  get   "/users/:user_id/requests" => "requests#index", as: :users_requests
  get   "/users/:user_id/requests/new" => "requests#new",as: :new_user_request
  patch "/users/:user_id/requests/:id" => "requests#update", as: :update_user_request
  post  "/users/:user_id/requests" => "requests#create", as: :create_user_request

############################################################
  # Resources of sessions
  delete "/logout" => "sessions#destroy", as: :logout
  resources :sessions, only: [:new, :create]

end
