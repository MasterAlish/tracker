class CreateAccessCredentials < ActiveRecord::Migration
  def change
    create_table :access_credentials do |t|
      t.text :properties

      t.timestamps
    end
  end
end
