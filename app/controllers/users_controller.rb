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
     if !User.exists?(params[:id])
      flash[:error] = "User doesn't exist"
      redirect_to root_path
    else
      @user = User.find(params[:id])
    end
  end

  def update
    @user = User.new(secure_params)
    saf
    if @user.update(secure_params)
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
    params.require(:user).permit(:name,:email,:age,:username,:password,:pass_confirm)
  end
end
