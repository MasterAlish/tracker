class AddNewToEmailItems < ActiveRecord::Migration
  def change
    add_column :email_items, :new, :integer
  end
end
