class WorkoutSession < ActiveRecord::Base
  attr_accessible :workout_id, :trainer_id, :client_id, :date, :reminder_sent, :workout_name, :exercise_sessions_attributes

  belongs_to :workout
  belongs_to :trainer
  belongs_to :client
  has_many :exercise_sessions

  accepts_nested_attributes_for :exercise_sessions, :allow_destroy => true#, :reject_if => lambda { |a| a[:exercise_name].blank? }

  #############################
  #     Instance Methods      #
  #############################

  def workout_name()
    workout.name unless workout.blank?
  end

  def workout_name=(wn)
		@workout_name = wn
	end
end
