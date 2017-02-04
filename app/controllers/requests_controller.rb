class RequestsController < ApplicationController
  before_action :current_user, :authorize_admin, only: [:index,:update,:destroy]
  # def show
  #   @request = Request.find(params[:id])
  #   # redirect_to user_path(@request)
  # end

  def index

  end

  def new
      # Create a new request (1 -> activate account)
      # if params[:type] == 1
      #   @user = User.find(params[:user_id])
      #   @request = @user.requests.where(acc_curr_st_id:3).first
      #   @request.req_type = "Act Account"
      #   @request.date = Time.now
      #   @request.req_st_id = 2 # Pending state
      #   @request.req_st_desc = "Pending"
      #   @request.description = "Activate this account"
      #   @request.acc_curr_st_id = 3 # Current state is inactive
      #   @request.acc_chgTo_st_id= 1 # Change state to active
      #   redirect_to users_requests(@request), method: "POST"
      # end
  end

  # Creates an actual request for admin user to
  def create
    asdf
    @request = Request.new
    # account change id to ...
    @request.acc_chgTo_st_id = params[:acc_chgTo_st]
    # Validate user's state. Current state will be 1 (active) otherwise 3 (inactive)
    params[:user_active] ? @request.acc_curr_st_id = 1 : @request.acc_curr_st_id = 3
    @request.req_type = "Account"
    @request.date = Time.now
    @request.req_st_id = 2 # defaults to 2 (pending)
    @request.req_st_desc = "Pending"
    @request.description = "#{session[:user_name]} requested to inactive the account"

    if current_user.requests.create(@request.attributes)
      redirect_to user_path(params[:user_id]), flash:{notice:"Request Created Succesfully!"}
    else
      redirect_to user_path(params[:user_id], flash:{error: "There was an error, creating request"})
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

  def secure_params
    # params.require[:request].permit
  end
end
