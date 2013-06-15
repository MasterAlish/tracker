class CreateEmailItems < ActiveRecord::Migration
  def change
    create_table :email_items do |t|
      t.string :content
      t.boolean :removed
      t.string :owner_type
      t.integer :owner_id
      t.integer :email_thread_id

      t.timestamps
    end
  end
end
