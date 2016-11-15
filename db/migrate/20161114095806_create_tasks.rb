class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.string :priority
      t.datetime :deadline

      t.timestamps
    end
  end
end
