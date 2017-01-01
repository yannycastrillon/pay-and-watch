class UsersController < ApplicationController

  def index
    @users = User.all
  end


  def show
    # Validates if user is loggedIn to show its details
    if not current_user
      redirect_to new_session_path, flash: {alert: "Warning! Please login"}
    else
      @user = User.find(params[:id])
    end
  end


  # Empty form for a new user
  def new
    @user = User.new
  end

  # Saves the @user from the FORM to the DB
  def create
    if not current_user
      redirect_to new_session_path, flash: {alert: "Warning! Please login"}
    else
      @user = User.new(secure_params)
      if @user.save
        redirect_to user_path(@user), flash: {success: "Well Done! account created Successfully"}
      else
        #TODO how to pass validaiton messages from the model to led user know
        render :new
      end
    end
  end

  # FORM to edit data of a current_user.
  def edit
    # if User doesn't exits on DB. (From Request tries someone to access an id not created yet)
    if not current_user
      redirect_to root_path, flash: {alert: "Warning! Please login to edit a profile"}
    else
      @user = current_user
      # @user = User.find(params[:id])
    end
  end

  def update
    # Look for user on DB from the params Id coming from the EDIT FORM
    @user = current_user
    # Validates to update @user with the secure_params which comes from the EDIT FORM
    if @user.update_attributes!(secure_params)
      redirect_to user_path(@user), flash: {success: "Account updated Successfully!"}
    else
      #TODO how to pass validaiton messages from the model to led user know
      render :new
    end
  end


  # Deletes a user from DB.
  def destroy
    if check_user?(params[:id])
      @user.find(params[:id]).destroy
    end
  end

  private
  # It will only permit those parameters to come from the view
  def secure_params
    # If pass_confirm is different from "" otherwise don't send them on secure_params method
      params.require(:user).permit(:name,:email,:age,:username,:password,(:pass_confirm unless params[:user][:pass_confirm].chomp == ""))
  end
end
