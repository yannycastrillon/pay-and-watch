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
    
  end

  def edit

  end

  def update
  end

  def destroy
  end

  private
  # It will only permit those parameters to come from the view
  def secure_params
    params.require(:user).permit(:name,:email,:age,:password,:password_confirmation)
  end
end
