class AddTaskRefToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :task_id, :integer, references: :tasks
  end
end
