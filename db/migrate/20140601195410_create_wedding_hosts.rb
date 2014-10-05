class CreateWeddingHosts < ActiveRecord::Migration
  def up
    create_table :wedding_hosts do |t|
      t.string :groom_name
      t.string :bride_name
      t.date   :wedding_date
      t.timestamps
    end
  end

  def down
    drop_table :wedding_hosts
  end
end
