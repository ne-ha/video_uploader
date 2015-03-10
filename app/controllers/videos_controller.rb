class VideosController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @videos = current_user.videos
  end

  def show
    @video = current_user.videos.find(params[:id])
  end

  def new
    @video = current_user.my_videos.new
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end
end
