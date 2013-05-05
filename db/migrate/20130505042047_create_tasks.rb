class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :ticket_id
      t.float :quoted_time
      t.float :real_time
      t.text :content
      t.integer :task_state
      t.integer :task_type_id
      t.integer :quoted_by
      t.integer :done_by

      t.timestamps
    end
  end
end
