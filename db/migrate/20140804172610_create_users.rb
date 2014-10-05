class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string  :name,              null: false, default: ""
      t.string  :email,              null: false, default: ""
      t.string :hashed_password, :limit => 40
      t.string :salt, :limit => 40


      t.timestamps
    end

    add_index :users, :email,                unique: true
  end
end
