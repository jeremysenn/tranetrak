class Client < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :phone, :dob, :trainer_id
  default_scope order: 'clients.first_name ASC'

  belongs_to :trainer
  belongs_to :user
  has_many :body_comps
end
