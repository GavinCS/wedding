class Guest < ActiveRecord::Base
  has_one :guest_address
  attr_accessor :password

  validates :name, :presence => true, :length => { :minimum => 3 }
#  validates :email, :presence => true #, :uniqueness => true
  validates_length_of :password, :in => 6..20, :allow_blank => true, :on => :update
  validates_confirmation_of :password


  #callbacks
  before_save :create_hashed_password, :create_access_token
  #before_update :create_access_token

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Guest.create! row.to_hash
    end
  end

  def self.generate_secure_password
    (0...8).map{65.+(rand(25)).chr}.join
  end

  def self.authenticate(email="", password="", token="")
    if token.blank?
      user = Guest.find_by_email(email)
      if user && user.password_match?(password)
        return user
      else
        return false
      end
    else
      user = Guest.find_by_access_token(token)
      if user && user.password_match?('',token)
        return user
      else
        return false
      end
    end



  end

  # The same password string with the same hash method and salt
  # should always generate the same hashed_password.
  def password_match?(password="", token="")
    if token.blank?
      hashed_password == Guest.hash_with_salt(password, salt)
    else
      access_token == token
    end


  end

  def self.make_salt(name="")
    Digest::SHA1.hexdigest("Use #{name} with #{Time.now} to make salt")
  end

  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end

  def get_rsvped
    Guest.sum(:pax, :conditions => {:rsvp => true})
  end

  def get_no_rsvp
    Guest.sum(:pax, :conditions => {:rsvp => false})
  end

  private

  def create_hashed_password
    # Whenever :password has a value hashing is needed

    unless password.blank?
      # always use "self" when assigning values
      self.salt = Guest.make_salt(name) if salt.blank?
      self.hashed_password = Guest.hash_with_salt(password, salt)
    end
  end

  def create_access_token
    if self.access_token.blank?
      self.access_token =  SecureRandom.urlsafe_base64(16)
    end
  end

end
