class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :notify
      t.datetime :reminder_date
      t.timestamps
    end
  end
end
