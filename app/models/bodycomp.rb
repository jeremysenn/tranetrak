class Bodycomp < ActiveRecord::Base
  validates :height,  :presence => {:message => "Height cannot be blank"}
  validates :weight, :presence => {:message => "Weight cannot be blank"}
  validates :pec, :presence => {:message => "Chest cannot be blank"}
  validates :umbilical, :presence => {:message => "Abdominal cannot be blank"}
  validates :quad, :presence => {:message => "Thigh cannot be blank"}

  belongs_to :client
end
