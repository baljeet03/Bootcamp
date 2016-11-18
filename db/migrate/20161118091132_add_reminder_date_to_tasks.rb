class AddReminderDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :reminderDate, :datetime
  end
end
