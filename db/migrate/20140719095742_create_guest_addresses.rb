class CreateGuestAddresses < ActiveRecord::Migration
  def change
    create_table :guest_addresses do |t|
      t.integer :guest_id
      t.string  :street_1
      t.string  :street_2
      t.string  :suburb
      t.string  :postcode
      t.string  :region
      t.integer :country_id

      t.timestamps
    end
  end

  def down
    drop_table :guest_addresses
  end
end
