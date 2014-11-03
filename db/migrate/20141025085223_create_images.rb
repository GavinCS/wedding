class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.string    :images
      t.string    :image_name
      t.integer   :gallery_id
      t.index     :image_name
      t.timestamps
    end
  end

  def down
    drop_table :images
  end
end
