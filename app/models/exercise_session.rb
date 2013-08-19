class ExerciseSession < ActiveRecord::Base
  attr_accessible :exercise_id, :workout_session_id, :rest, :sets, :trainer_id, :client_id, :exercise_name

  belongs_to :exercise
  belongs_to :trainer
  belongs_to :client
  belongs_to :workout_session

  def exercise_name()
    exercise.name unless exercise.blank?
  end

  def exercise_name=(en)
		@exercise_name = en
	end
end
