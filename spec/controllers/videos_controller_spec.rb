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

  describe 'Create video' do
    context "when all value is given" do
      it "should upload video" do
        expect{ post :create , video: {name: 'Minecraft', description: 'This is the video of minecraft',
        category_id: @category.id, 
        avatar: Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'uploads', 'video', 'avatar', 'Minecraft_ ROCK PAPER SCISSORS OF DEATH GAME - Animation.mp4'))}}.to change{Video.count}.by(1)
        expect(flash[:success]).to eq("Video has been uploaded.")
      end
    end

    context "when avatar is nil" do
      it "should upload video" do
        expect{ post :create , video: {name: 'Minecraft', description: 'This is the video of minecraft',
        category_id: @category.id, 
        avatar: nil }}.to change{Video.count}.by(0)
        expect(flash[:notice]).to eq("Video cannot be uploaded.")
      end
    end

    context "when name is empty" do
      it "name should not be empty" do
        expect{ post :create , video: {name: '' , description: 'This is the video of minecraft',
        category_id: @category.id, 
        avatar: Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'uploads', 'video', 'avatar', 'Minecraft_ ROCK PAPER SCISSORS OF DEATH GAME - Animation.mp4'))}}.to change{Video.count}.by(0)
        expect(flash[:notice]).to eq("Name cannot be empty.")
      end
    end
  end

  describe 'Delete action' do
    it "should delete a video" do
      @video = FactoryGirl.create(:video)
      @video.user_id = @user.id
      @video.save
      expect{delete :destroy , :id =>@video}.to change{Video.count}.by(-1)
      expect(flash[:success]).to eq("Video deleted successfully.")
    end
  end

  describe 'Render new template'do
    it "should render new template" do
      get :new
      expect(response).to render_template("videos/new")
    end
  end

  describe 'update' do
    it "should update the user ids" do
      @video = FactoryGirl.create(:video)
      @video.users << @user
      @another = User.create(email:"example@test.com",
                            password: "aaaaaaaa",
                            password_confirmation: "aaaaaaaa",
                            confirmed_at: Time.now)
      patch :update, :id => @video.id, :video => {:user_id=> @another.id} , :commit => "Share"
      expect(flash[:success]).to eq("Video is shared to other users.")
    end
  end
end