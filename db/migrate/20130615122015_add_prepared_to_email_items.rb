class AddPreparedToEmailItems < ActiveRecord::Migration
  def change
    add_column :email_items, :prepared, :boolean, :default=>FALSE
  end
end
