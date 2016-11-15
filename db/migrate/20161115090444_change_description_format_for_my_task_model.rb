class ChangeDescriptionFormatForMyTaskModel < ActiveRecord::Migration

  def change
    change_column :tasks, :description, :text
  end
  # def up
  # end
  #
  # def down
  # end
end
