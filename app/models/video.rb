class Video < ActiveRecord::Base

  has_and_belongs_to_many :users
  belongs_to :category

  validates :name , :presence => true

  mount_uploader :avatar, AvatarUploader
  
end
