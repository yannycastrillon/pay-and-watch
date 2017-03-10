class UsersController < ApplicationController

  # User current active
  def index
    # @users = User.where(active:true).order(:id)
    @users = User.actives.order_by_id
  end

  def show
    # Validates if user is loggedIn to show its details
    if not current_user
      redirect_to new_session_path, flash: {alert: "Warning! Please login"}
    else
      @user = current_user
    end
  end


  # Empty form for a new user
  def new
    @user = User.new
  end

  # Saves the @user from the FORM to the DB
  def create
      @user = User.new(secure_params)
      if @user.save
        redirect_to user_path(@user), flash: {success: "Well Done! account created Successfully"}
      else
        # Validates textfields errors and builds up the html to show on the page
        validation_error_messages(@user)
        render :new
      end
    # end
  end

  # FORM to edit data of a current_user.
  def edit
    # if User doesn't exits on DB. (From Request tries someone to access an id not created yet)
    if not current_user
      redirect_to root_path, flash: {alert: "Warning! Please login to edit a profile"}
    else
      @user = current_user
    end
  end

  def update
    # Look for user on DB from the params Id coming from the EDIT FORM
    @user = current_user
    # Validates to update @user with the secure_params which comes from the EDIT FORM
    if @user.update_attributes!(secure_params)
      redirect_to user_path(@user), flash: {success: "Account updated Successfully!"}
    else
      # Validates text field errors and builds up the html to show on the page
      validation_error_messages(@user)
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
  # Validates text field errors and shows them on a flash message.
  def validation_error_messages(user)
    if user.errors.any?
      errors = "<ul>"
      user.errors.full_messages.each do |message|
        errors += "<li>#{message}</li>"
      end
    end
    errors += "</ul>"
    flash[:error] = errors
  end

  # It will only permit those parameters to come from the view
  def secure_params
    # If pass_confirm is different from "" otherwise don't send them on secure_params method
      params.require(:user).permit(:name,:email,:age,:username,:password,:password_confirmation)
      # (:pass_confirm unless params[:user][:pass_confirm].chomp == "")
  end
end
