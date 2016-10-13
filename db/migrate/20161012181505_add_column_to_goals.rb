class AddColumnToGoals < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :picture, :string
  end
end
