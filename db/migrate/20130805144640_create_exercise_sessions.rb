class CreateExerciseSessions < ActiveRecord::Migration
  def self.up
    create_table :exercise_sessions do |t|
      t.integer :exercise_id
      t.integer :workout_session_id
      t.string :rest
      t.string :sets
      t.integer :trainer_id
      t.string :client_id
      t.timestamps
    end
  end

  def self.down
    drop_table :exercise_sessions
  end
end
