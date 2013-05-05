class CreateTaskTypes < ActiveRecord::Migration
  def change
    create_table :task_types do |t|
      t.string :name
      t.string :image

      t.timestamps
    end

    TaskType.create!(name: "bug", image: "assets/task_types/bug.png")
    TaskType.create!(name: "task", image: "assets/task_types/task.png")
    TaskType.create!(name: "proposal", image: "assets/task_types/idea.png")
    TaskType.create!(name: "enhancement", image: "assets/task_types/enhancement.png")
    TaskType.create!(name: "fix", image: "assets/task_types/fix.png")
  end
end
