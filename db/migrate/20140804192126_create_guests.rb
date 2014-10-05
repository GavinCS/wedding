class CreateGuests < ActiveRecord::Migration
  def up
    create_table :guests do |t|
      t.string  :name
      t.string  :partner_name
      t.string  :email
      t.string :hashed_password, :limit => 40
      t.string :salt, :limit => 40
      t.string :access_token, :limit => 40
      t.integer :pax, :default => 1
      t.boolean  :rsvp, :default => false

      t.index :email
      t.timestamps
    end
  end

  def down
    drop_table :guests
  end
end
