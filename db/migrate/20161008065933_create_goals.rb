class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.float :target_amount
      t.float :penalty_amount
      t.boolean :is_goal_validated
      t.datetime :deadline

      t.timestamps
    end
  end
end
