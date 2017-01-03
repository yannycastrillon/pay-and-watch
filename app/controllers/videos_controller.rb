class VideosController < ApplicationController
  # This is like the middleware which gets executed before any action of the controller
  before_action :authorize_admin, only: [:new,:create,:update,:destroy]

  def index
    @videos = Video.all
  end

  def show

  end

  def new

  end

  def create

  end

  def edit
  end

  def update
  end

  def destroy
  end
end
