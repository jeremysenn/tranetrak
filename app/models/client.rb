class Client < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :phone, :dob, :trainer_id, :image, :remote_image_url
#  default_scope order: 'clients.first_name ASC'
  acts_as_birthday :dob
  mount_uploader :image, ImageUploader

  resourcify

  belongs_to :trainer
  belongs_to :user
  has_many :bodycomps
  has_many :workouts
  has_many :workout_sessions

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true

  def full_name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    else
      id.to_s
    end
  end

  def name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    else
      id.to_s
    end
  end
end
