class SessionsController < ApplicationController
  def new
  end


  # It is in charge of getting the "Id" from user and assigns that to the session hash.
  def create
    # Checks for the user by email.
    @user = User.find_by_email(params[:email])
    # Validates the existence of that @user and then authenticates with the password from the form.
    if @user and @user.authenticate(params[:password])
      if !@user.active
        # What type of request is send to new action (1 --> activate account)
        redirect_to new_user_request_path(@user), flash:{alert:"Your account is currently Inactive"} and return
      end
      # Assign Session that holds the @user.id
      session[:user_id] = @user.id
      # Asigns the user's "name" to the Session hash
      session[:user_name]= @user.name
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
    session[:user_name] = nil
    redirect_to root_path
  end
end
