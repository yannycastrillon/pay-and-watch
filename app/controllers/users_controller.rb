class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(secure_params)
    if @user.save
      flash[:success] = "You account has been created Successfully"
      redirect_to user_path(@user)
    else
      #TODO how to pass validaiton messages from the model to led user know
      render :new
    end
  end

  def edit
    # if User doesn't exits on DB. (From Request tries someone to access an id not created yet)
    if User.exists?(params[:id])
      @user = User.find(params[:id])
    else
      flash[:error] = "User doesn't exist"
      redirect_to root_path
    end
  end

  def update
    # Look for user on DB from the params Id coming from the EDIT FORM
    @user = User.find(params[:id])
    # Validates to update @user with the secure_params which comes from the EDIT FORM
    if @user.update_attributes!(secure_params)
      flash[:success] = "Account updated Successfully"
      redirect_to user_path(@user)
    else
      #TODO how to pass validaiton messages from the model to led user know
      render :new
    end
  end

  def destroy
    @user.destroy
  end

  private
  # It will only permit those parameters to come from the view
  def secure_params
    # If pass_confirm is different from "" otherwise don't send them on secure_params method
      params.require(:user).permit(:name,:email,:age,:username,:password,(:pass_confirm unless params[:user][:pass_confirm].chomp == ""))
  end
end
