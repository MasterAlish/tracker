class AddUidToEmailItem < ActiveRecord::Migration
  def change
    add_column :email_items, :uid, :integer
  end
end
