class UsersController < ApplicationController

  def index
    @users = User.all
  end


  def show
    if check_user?(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to users_path, flash: {error: "Error! The user does't exists"}
    end
  end


  # Empty form for a new user
  def new
    @user = User.new
  end

  def create
    @user = User.new(secure_params)
    if @user.save
      redirect_to user_path(@user), flash: {success: "Well Done! account created Successfully"}
    else
      #TODO how to pass validaiton messages from the model to led user know
      render :new
    end
  end

  # Form to change information from user.
  def edit
    # if User doesn't exits on DB. (From Request tries someone to access an id not created yet)
    if check_user?(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to root_path, flash: {error: "Error! User doesn't exist"}
    end
  end

  def update
    # Look for user on DB from the params Id coming from the EDIT FORM
    @user = User.find(params[:id])
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

  # Validates if the current id-user exits.
  def check_user?(id)
    User.exists?(id)
  end
  # It will only permit those parameters to come from the view
  def secure_params
    # If pass_confirm is different from "" otherwise don't send them on secure_params method
      params.require(:user).permit(:name,:email,:age,:username,:password,(:pass_confirm unless params[:user][:pass_confirm].chomp == ""))
  end
end
