class Exercise < ActiveRecord::Base
  attr_accessible :name, :description, :trainer_id, :client_id

  has_many :exercise_sessions
end
