class Trainer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_id, :company_name, :pictures_attributes

  belongs_to :user
  has_many :clients
  has_many :bodycomps, :through => :clients
  has_many :workouts
  has_many :workout_sessions
  has_many :pictures, :as => :imageable,  :dependent => :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true, :reject_if => lambda { |a| a[:image].blank? }

  def full_name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    else
      id
    end
  end

end
