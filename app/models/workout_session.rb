class WorkoutSession < ActiveRecord::Base
  attr_accessible :workout_id, :trainer_id, :client_id, :date, :reminder_sent

  belongs_to :workout
  belongs_to :trainer
  belongs_to :client

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
