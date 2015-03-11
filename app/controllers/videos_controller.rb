class VideosController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @videos = Kaminari.paginate_array(current_user.videos).page(params[:page]).per(5)
  end

  def show
    @video = current_user.videos.find(params[:id])
  end

  def new
    @video = current_user.my_videos.new
  end

  def create
    @video = current_user.my_videos.create(video_params)
    if @video.save
      @video.users << current_user
      flash[:success] = "Video has been uploaded."
      redirect_to(root_path)
    elsif @video.name.empty?
      flash[:notice] = "Name cannot be empty."
      render :new
    elsif @video.avatar.empty?
      flash[:notice] = "File cannot be empty."
      render :new
    else 
      flash[:notice] = "Video cannot be uploaded."
      render :new
    end
  end

  def update
    @video = current_user.videos.find(params[:id])
    if @video.update_attributes(video_params)
      if params[:commit] == 'Share'
        flash[:success] = "Video is shared to other users."
      end
    else
      flash[:notice] = "Video cannot be shared to other users."
    end
    redirect_to(root_path)
  end

  def destroy
    @video = current_user.my_videos.find(params[:id])
    if @video.destroy
      flash[:success] = "Video deleted successfully."
    else
      flash[:notice] = "Video not deleted."
    end
    redirect_to(root_path)
  end

  def share_video
    @video = Video.find(params[:video_id])
  end

  private
    def video_params
      params.require(:video).permit(:name, :description, :avatar, :category ,:user_ids => [])
    end
end
