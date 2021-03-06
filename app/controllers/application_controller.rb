class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :authorize_admin

  # IF the current_user is logged_in then it returns that user object value method.
  # THEN if the current_user is not logged_in then it goes to the dataBase to check that
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Validates if current_user is logged_in
  def logged_in?
    !!@current_user
  end

  # Validates if current_user has admin privileges
  def isAdmin?
    redirect_to new_session_path, flash: {:error => "Warning! Only Admin privileges"} unless logged_in? 
    !!@current_user.admin
  end

  # Validates if not an admin user then redirects to the home page. (root path)
  def authorize_admin
    redirect_to root_path, flash: {:error => "User don't have admin privileges"} unless isAdmin?
  end
end
