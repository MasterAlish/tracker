class CreateEmailItems < ActiveRecord::Migration
  def change
    create_table :email_items do |t|
      t.text :content
      t.boolean :removed, default: FALSE
      t.string :owner_type
      t.integer :owner_id
      t.integer :email_thread_id

      t.timestamps
    end
  end
end
