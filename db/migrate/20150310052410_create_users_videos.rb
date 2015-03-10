class CreateUsersVideos < ActiveRecord::Migration
  def change
    create_table :users_videos do |t|
      t.belongs_to :user, index: true
      t.belongs_to :video, index: true
    end
  end
end
