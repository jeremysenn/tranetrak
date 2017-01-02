class Client < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :phone, :dob, :trainer_id, :image, :remote_image_url, :sex, :height, :height_units
#  default_scope order: 'clients.first_name ASC'
  acts_as_birthday :dob
  mount_uploader :image, ImageUploader

  resourcify
  
  after_create :subscribe_to_mailchimp_list

  belongs_to :trainer
  belongs_to :user
  has_many :bodycomps
  has_many :workouts
  has_many :workout_sessions

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  
  def subscribe_to_mailchimp_list
    begin
      gb = Gibbon::API.new
      gb.lists.subscribe({:id => "77aaaa99ba", :email => {:email => email}, 
        :merge_vars => {:FNAME => first_name, :LNAME => last_name}, :double_optin => false, :send_welcome => false})
    rescue Gibbon::MailChimpError => e
      puts "Problem with MailChimp Gibbon: #{e.message}"
    end
    
  end

  def full_name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    else
      id.to_s
    end
  end

  def name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    else
      id.to_s
    end
  end
end
