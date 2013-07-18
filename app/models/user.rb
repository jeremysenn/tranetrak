class User < ActiveRecord::Base
  rolify
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :is_trainer, :is_client, :first_name, :last_name
  has_one :trainer
  has_one :client
  has_many :bodycomps, :through => :client

  attr_accessor :password
  before_save :prepare_password

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :username, :presence => true
  validates :email, :presence => true
  validates_uniqueness_of :username, :email #, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates :password, :presence => true, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  def welcome_email
    UserMailer.welcome(self).deliver
  end

  def full_name
    if !first_name.blank? || !last_name.blank?
      "#{first_name} #{last_name}".strip
    else
      id.to_s
    end
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end
