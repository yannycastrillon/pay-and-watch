class VideosController < ApplicationController
  # This is like the middleware which gets executed before any action of the controller
  before_action :current_user, :authorize_admin, only: [:new,:create,:update,:destroy]


  # Home page
  def index
    @videos = Video.all
  end

  # Video description and Information
  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
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
