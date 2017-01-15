class RequestsController < ApplicationController
  before_action :current_user
  def show
    @request = Request.find(params[:id])
    redirect_to user_path(@request)
  end

  def create

    @request = Request.new
    @request.request_type = "Change Account"
    @request.date = Date.today
    @request.state_id =  2
    # 1)-active 2)-pending 3)-inactive
    case @request.state_id
      when 2
        @request.state = "Pending"
      when 1
        @request.state = "Active"
      else
        @request.state = "Inactive"
    end

    @request.description = "The User with id: #{params[:user_id]}, requested to Inactivate his/her account"

    if current_user.requests.create(@request.attributes)
      redirect_to user_path(params[:user_id]), flash:{notice:"Request Created Succesfully!"}
    end
  end

  def update
  end

  def destroy
  end


end
