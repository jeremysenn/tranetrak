class Workout < ActiveRecord::Base
  attr_accessible :name, :description, :trainer_id, :client_id

  belongs_to :trainer
  belongs_to :client
  has_many :workout_sessions
end
