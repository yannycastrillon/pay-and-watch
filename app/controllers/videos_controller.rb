class VideosController < ApplicationController
  # This is like the middleware which gets executed before any action of the controller
  before_action :current_user, :authorize_admin, only: [:new,:create,:edit,:update,:destroy,:inactive_videos]
  before_action :set_video, except: [:index,:new,:create,:inactive_videos,:activate]


  # Home page - All videos that are currently active appear in the home.
  def index
    @videos = Video.actives.order_by_id
  end

  # Video description and Information
  def show
  end

  # New Video form
  def new
    @video = Video.new
  end
  # Video creation on DB
  def create
    @video = Video.new(secure_params_video)
    @video.set_defaults
    if @video.save
      redirect_to root_path, flash: {success: "Video was created Successfully!"}
    else
      validation_error_messages(@video)
      render :new
    end
  end

  # Edit an existing video
  def edit
  end

  # Video update on DB
  def update
    if @video.update_attributes(secure_params_video)
      redirect_to root_path, flash: {success: "Video was successfully updated!"}
    else
      validation_error_messages(@video)
      render :edit
    end
  end

  # It inactivates a video
  def destroy
    if @video.update_attributes(active:false)
      redirect_to root_path, flash: {success: "Video was successfully inactive!"}
    else
      validation_error_messages(@video)
      render :show
    end
  end

  # List all the inactive videos
  def inactive_videos
    @inactive_videos = Video.inactives.order_by_id
    render partial: "inactive_videos"
  end

  # Activates video
  def activate
    msg = Video.find(params[:id]).activate_video
    redirect_to root_path, flash:msg
  end

  private

  # Sets video for actions show, edit, update, destroy
  def set_video
    @video = Video.find(params[:id])
  end

  # Validates input-fields messages
  def validation_error_messages(video)
    if video.errors.any?
      errors = "<ul>"
      video.errors.full_messages.each do |message|
        errors += "<li>#{message}</li>"
      end
    end
    errors += "</ul>"
    flash[:error] = errors
  end

  # Passing of secure params from the website.
  def secure_params_video
    params.require(:video).permit(:name,:url,:price,:description)
  end
end
