class SessionsController < ApplicationController
  def new
  end


  # It is in charge of getting the "Id" from user and assigns that to the session hash.
  def create
    # Checks for the user by email.
    @user = User.find_by_email(params[:email])
    # Validates the existence of that @user and then authenticates with the password from the form.
    if @user and @user.authenticate(params[:password])
      # Session that holds the @user.id
      session[:user_id] = @user.id
      flash[:success] = "Success! You are now loggedIn"
      redirect_to user_path(@user)
    else
      flash[:error] = "Oops!Email or Password incorrect. Try again"
      redirect_to new_session_path
    end
  end

  # Session Id sets to nil
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
