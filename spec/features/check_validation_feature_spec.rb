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

  it "should not abe able to upload if name is empty" do
    visit root_path
    click_link "Upload Video"
    within(".new") do
      fill_in  'Name', :with => ''
      fill_in  'Description', :with => 'secret'
      select "Music" , :from=> "video_category_id"
    end
    click_button "Upload"
    expect(page).to have_content "Name cannot be empty."
  end
end