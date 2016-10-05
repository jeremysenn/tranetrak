class AddSexHeightAndHeightUnitsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :sex, :string
    add_column :clients, :height, :integer
    add_column :clients, :height_units, :string
  end
end
