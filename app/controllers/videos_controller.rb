class VideosController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @videos = current_user.videos
  end

  def show
    @video = current_user.videos.find(params[:id])
  end

  def new
    @video = current_user.videos.new
  end

  def create
    @video = current_user.videos.create(video_params)
    if @video.save
      flash[:success] = "Video has been uploaded."
      redirect_to(root_path)
    else 
      flash[:notice] = "Video cannot be uploaded."
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private
    def video_params
      params.require(:video).permit(:name, :description, :avatar)
    end
end
