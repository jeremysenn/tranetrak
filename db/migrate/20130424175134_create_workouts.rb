class CreateWorkouts < ActiveRecord::Migration
  def self.up
    create_table :workouts do |t|
      t.string :name
      t.text :description
      t.integer :trainer_id
      t.integer :client_id
      t.timestamps
    end
  end

  def self.down
    drop_table :workouts
  end
end
