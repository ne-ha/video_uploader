require 'rails_helper'

describe Video, type: :model do

  describe "name" do
    it "should be required" do
      video = Video.new(name: nil)
      video.valid?
      expect(video).to be_invalid
    end
  end

  describe "avatar" do
    it "should be required" do
      video = Video.new(avatar: nil)
      video.valid?
      expect(video).to be_invalid
    end
  end
end
