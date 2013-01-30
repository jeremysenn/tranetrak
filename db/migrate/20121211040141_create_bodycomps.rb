class CreateBodycomps < ActiveRecord::Migration
  def change
    create_table :bodycomps do |t|
      t.date :date
      t.integer :client_id
      t.integer :age
      t.integer :height
      t.string :height_units, :default => "inches"
      t.integer :weight
      t.string :weight_units, :default => "pounds"
      t.float :pec
      t.float :tri
      t.float :subscap
      t.float :suprailiac
      t.float :midaxil
      t.float :umbilical
      t.float :calf
      t.float :bicep
      t.float :low_back
      t.float :quad
      t.string :sex
      t.float :waist
      t.float :hip
      t.float :neck
      t.float :shoulder
      t.float :chest
      t.float :arm
      t.float :thigh
      t.float :gastroc
      t.string :circumference_units, :default => "inches"
      t.text :notes

      t.timestamps
    end
  end
end
