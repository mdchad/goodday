class AddColumnsToGoals < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :is_goal_completed, :boolean
    add_column :goals, :total_pledged_amount, :float
  end
end
