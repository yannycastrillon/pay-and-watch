Rails.application.routes.draw do
  root "users#index"
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

end
