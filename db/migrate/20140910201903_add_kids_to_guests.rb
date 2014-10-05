class AddKidsToGuests < ActiveRecord::Migration
  def up
    add_column :guests, :kids, :string
    add_column :guests, :notes, :string
    add_column :guests, :save_the_date_mail, :boolean
    add_column :guests, :rsvp_mail, :boolean
  end

  def down
    remove_column :guests, :kids
    remove_column :guests, :notes
    remove_column :guests, :save_the_date_mail
    remove_column :guests, :rsvp_mail
  end

end
