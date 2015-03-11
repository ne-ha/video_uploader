require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe "user", :type=> :feature, :js => true do

  before :each do
    User.destroy_all
    Category.destroy_all
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)

    FactoryGirl.create(:category)
  end

  after :each do
    Warden.test_reset!
  end

  it "should be able to upload video" do
    visit root_path
    click_link "Upload Video"
    within(".new") do
      fill_in  'Name', :with => 'test'
      fill_in  'Description', :with => 'secret'
      select "Music" , :from=> "video_category_id"
      attach_file('video[avatar]',"#{Rails.root}/public/uploads/video/avatar/Minecraft_ ROCK PAPER SCISSORS OF DEATH GAME - Animation.mp4")
    end
    click_button "Upload"
    expect(page).to have_content "Video has been uploaded."
  end

end