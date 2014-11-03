class Accommodation < ActiveRecord::Base
  mount_uploader :image ,ImagesUploader
  geocoded_by :address

  validate :img_uniqueness
  after_validation :geocode, :if => :address_changed?

  def img_uniqueness
     if Accommodation.where(:image => self.image.filename).first
       errors.add :image, "Image already exists in database"
     end
  end

  def previous
    Accommodation.where(["id < ?", id]).last
  end

  def next
    Accommodation.where(["id > ?", id]).first
  end

end
