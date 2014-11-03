class Image < ActiveRecord::Base
  mount_uploader :images, ImagesUploader
  belongs_to :gallery, foreign_key: :gallery_id, counter_cache: :image_count

  validate :img_uniqueness

  def img_uniqueness
    errors.add :images, "Image already exists in database" if Image.where(:images => self.images.filename).first
  end
end
