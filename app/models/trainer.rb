class Trainer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_id

  belongs_to :user
  has_many :clients
  has_many :bodycomps, :through => :clients
  has_many :workouts
  has_many :workout_sessions

  def full_name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    else
      id
    end
  end

end
