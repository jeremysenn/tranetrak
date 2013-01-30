class AddIsTrainerAndIsClientToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_trainer, :boolean
    add_column :users, :is_client, :boolean
  end
end
