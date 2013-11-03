class Plan < ActiveRecord::Base
  attr_accessible :name, :stripe_plan_id, :price, :description

  has_many :subscriptions
end
