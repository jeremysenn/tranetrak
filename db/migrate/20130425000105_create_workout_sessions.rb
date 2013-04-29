class CreateWorkoutSessions < ActiveRecord::Migration
  def self.up
    create_table :workout_sessions do |t|
      t.integer :workout_id
      t.integer :trainer_id
      t.integer :client_id
      t.datetime :date
      t.boolean :reminder_sent, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :workout_sessions
  end
end
