class AddFieldsToEmailThread < ActiveRecord::Migration
  def change
    add_column :email_threads, :removed, :boolean
    add_column :email_threads, :tags, :text
  end
end
