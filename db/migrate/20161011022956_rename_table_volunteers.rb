class RenameTableVolunteers < ActiveRecord::Migration[5.0]
  def change
    add_reference :volunteers, :campaign, foreign_key: true
    add_reference :donations, :campaign, foreign_key: true
    add_reference :volunteers, :user, foreign_key: true
    add_reference :donations, :user, foreign_key: true
    add_column :campaigns, :target_amount, :float
  end
end
