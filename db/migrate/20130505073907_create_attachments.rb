class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :url
      t.string :type
      t.integer :task_id

      t.timestamps
    end
  end
end
