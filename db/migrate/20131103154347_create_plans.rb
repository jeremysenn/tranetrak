class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.string :name
      t.float :price
      t.text :description
      t.integer :stripe_plan_id
      t.timestamps
    end
  end

  def self.down
    drop_table :plans
  end
end
