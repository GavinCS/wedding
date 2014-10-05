require 'digest/sha1'
class User < ActiveRecord::Base
  attr_accessor :password
  has_one :wedding_host

  validates :name, :presence => true, :length => { :minimum => 5 }
  validates :email, :presence => true, :uniqueness => true
  validates_length_of :password, :in => 6..20, :allow_blank => true, :on => :update
  validates_confirmation_of :password


  #callbacks
  before_save :create_hashed_password

  def self.generate_secure_password
    (0...8).map{65.+(rand(25)).chr}.join
  end

  def self.authenticate(email="", password="")
    user = User.find_by_email(email)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end

  # The same password string with the same hash method and salt
  # should always generate the same hashed_password.
  def password_match?(password="")
    hashed_password == User.hash_with_salt(password, salt)
  end

  def self.make_salt(name="")
    Digest::SHA1.hexdigest("Use #{name} with #{Time.now} to make salt")
  end

  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end

  private

  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      # always use "self" when assigning values
      self.salt = User.make_salt(name) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end

end
