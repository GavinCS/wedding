class CreateMailTemplates < ActiveRecord::Migration
  def up
    create_table :mail_templates do |t|
      t.string :name
      t.string :template
      t.string :description
      t.timestamps
    end
  end

  def down
    drop_table :mail_templates
  end
end
