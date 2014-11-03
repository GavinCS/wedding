class CreateAccommodations < ActiveRecord::Migration
  def up
    create_table :accommodations do |t|
      t.string :name
      t.string :contact_number
      t.string :email
      t.string :website
      t.string :image
      t.string :address
      t.string :latitude
      t.string :longitude
      t.timestamps
    end
  end

  def down
    drop_table :accommodations
  end
end
