require 'rails_helper'

describe VideosController do

  before :each do
    User.destroy_all
    @user = FactoryGirl.create(:user)
    @category = FactoryGirl.create(:category)
    sign_in :user, @user
  end

  describe 'GET index' do
    context "when user is loged in " do
      it "should render index template" do
        get :index
        expect(response).to render_template("videos/index")
      end
    end
  end

    it "should upload video" do
      expect{ post :create , video: {name: 'Minecraft', description: 'This is the video of minecraft',
        category_id: @category.id, 
        avatar: Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'uploads', 'video', 'avatar', 'Minecraft_ ROCK PAPER SCISSORS OF DEATH GAME - Animation.mp4'))}}.to change{Video.count}.by(1)
    end

    it "should delete a video" do
      @video = FactoryGirl.create(:video)
      @video.user_id = @user.id
      @video.save
      expect{delete :destroy , :id =>@video}.to change{Video.count}.by(-1)
    end

    it "should render new template" do
      get :new
      expect(response).to render_template("videos/new")
    end
end