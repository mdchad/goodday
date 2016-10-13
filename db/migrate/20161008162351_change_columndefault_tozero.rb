class ChangeColumndefaultTozero < ActiveRecord::Migration[5.0]
  def up
    change_column_default :goals, :total_pledged_amount, 0
    change_column_default :goals, :is_goal_validated, false
    change_column_default :goals, :is_goal_completed, false
  end
  def down
    change_column_default :goals, :total_pledged_amount, nil
    change_column_default :goals, :is_goal_validated, nil
    change_column_default :goals, :is_goal_completed, nil
  end
end
