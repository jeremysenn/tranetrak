class Picture < ActiveRecord::Base
  attr_accessible :image, :title, :imageable_id, :imageable_type
  mount_uploader :image, ImageUploader

  belongs_to :imageable, :polymorphic => true
end
