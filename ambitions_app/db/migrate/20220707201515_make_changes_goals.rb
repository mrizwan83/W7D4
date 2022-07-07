class MakeChangesGoals < ActiveRecord::Migration[5.2]
  def change
    change_column :goals, :completed, :boolean , default: false
  end
end
