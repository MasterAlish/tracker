class AddTicketIdToEmailThread < ActiveRecord::Migration
  def change
    add_column :email_threads, :ticket_id, :integer
  end
end
