class CreateEmailThreads < ActiveRecord::Migration
  def change
    create_table :email_threads do |t|
      t.string :email
      t.string :title

      t.timestamps
    end
  end
end
