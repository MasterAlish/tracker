class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :owner_type
      t.integer :owner_id
      t.text :data

      t.timestamps
    end
  end
end
