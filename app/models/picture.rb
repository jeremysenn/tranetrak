class Picture < ActiveRecord::Base
  attr_accessible :image, :title, :imageable_id, :imageable_type
  mount_uploader :image, ImageUploader
  before_create :default_title

  belongs_to :imageable, :polymorphic => true

  def default_title
    self.title ||= File.basename(image_url, '.*').titleize
  end
end
