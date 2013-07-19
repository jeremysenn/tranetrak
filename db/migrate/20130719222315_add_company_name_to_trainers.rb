class AddCompanyNameToTrainers < ActiveRecord::Migration
  def change
    add_column :trainers, :company_name, :string
  end
end
