class RequestsController < ApplicationController
  before_action :current_user, :authorize_admin, only: [:index,:update,:destroy]


  def index

  end

  # Form to request an activation of account
  def new
    @request = Request.new(user_id:params[:user_id])
    @user = User.find(params[:user_id])
  end

  def create
    if params[:user_active].to_b
      inactivate_request(Request.new)
    else
      user = User.find(params[:user_id])
      activate_request(user)
    end
  end

  # updates requests
  def update
    @request = Request.find(params[:request][:req_id])
    @request.acc_old_st_id = params[:request][:curr_st]
    @request.acc_curr_st_id= params[:request][:chg_to]
    @request.req_st_id = 1 # request state change to 1 (done)
    @request.req_st_desc = "Done" # description of the "request state id"
    if Request.update(@request.id, @request.attributes)
      # Inactivates the account of the specific user
      @user = @request.user
      @user.active = false
      User.update(@user.id, @user.attributes)
      redirect_to user_path(params[:user_id]), flash: {success: "Request updated and #{@user.name} account was Inactivated succesfully"}
    end
  end

  def destroy
  end

  private

  # Sends Email to activate account request
  def activate_request(user)
    if user.update_attributes(active:true)
      UserMailer.activate_email(user).deliver_later
      redirect_to new_session_path, flash:{success: "Email sent succesfully!"}
    else
      redirect_to new_session_path, flash:{error: "Contact Us, account could not get activated!"}
    end
  end

  def inactivate_request(request)
    request.acc_chgTo_st_id = params[:acc_chgTo_st]
    # Validate state. Current state will be 1 (active) otherwise 3 (inactive)
    params[:user_active] ? request.acc_curr_st_id = 1 : request.acc_curr_st_id = 3
    request.req_type = "Account"
    request.date = Time.now
    request.req_st_id = 2 # defaults to 2 (pending)
    request.req_st_desc = "Pending"
    request.description = "#{session[:user_name]} requested to inactive the account"

    if current_user.requests.create(request.attributes)
      redirect_to user_path(params[:user_id]), flash:{notice:"Request Created Succesfully!"}
    else
      redirect_to user_path(params[:user_id], flash:{error: "There was an error, creating request"})
    end
  end


  def secure_params
    # params.require[:request].permit
  end
end
