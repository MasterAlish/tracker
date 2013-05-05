class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.integer :client_id
      t.integer :site

      t.timestamps
    end
  end
end
