class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :url
      t.integer :client_id

      t.timestamps
    end
  end
end
