class CreateGalleries < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
      t.string :album_name
      t.integer :image_count, :default => 0
      t.index :album_name
      t.boolean :hide_from_public, :default => false
      t.timestamps
    end
  end

  def down
    drop_table :galleries
  end
end
