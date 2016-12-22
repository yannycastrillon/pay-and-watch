Rails.application.routes.draw do
  root "users#index"
  # It will list all users account
  get "/users" => "users#index"

  # It will show a form to create a new User account.
  get "/users/new" => "users#new"
  post "/users" => "users#create" # It will save User in DB.

  # It will show an user account
  get "/users/:id" => "users#show"
  # It will edit an account information
  get "/users/:id/edit" => "users#edit"
  patch "/users" => "users#update"

  # It will delete an account
  delete "/users/:id" => "users#destroy"

end
