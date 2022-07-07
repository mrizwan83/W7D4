class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text  :details, null: false
      t.boolean :private, null: false
      t.boolean :completed, null: false
      t.timestamps
    end
  end
end
