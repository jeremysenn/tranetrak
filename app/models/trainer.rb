class Trainer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_id

  belongs_to :user
  has_many :clients
  has_many :bodycomps, :through => :clients
end
