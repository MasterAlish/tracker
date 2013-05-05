class CreateTaskStates < ActiveRecord::Migration
  def change
    create_table :task_states do |t|
      t.string :name

      t.timestamps
    end

    TaskState.create!(name: "Order")
    TaskState.create!(name: "New")
    TaskState.create!(name: "Quote")
    TaskState.create!(name: "Implementation")
    TaskState.create!(name: "Test")
    TaskState.create!(name: "Client-Consent")
    TaskState.create!(name: "Delivering")
    TaskState.create!(name: "Support")
  end
end
