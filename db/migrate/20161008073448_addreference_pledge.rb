class AddreferencePledge < ActiveRecord::Migration[5.0]
  def change
      add_reference :pledges, :goal, foreign_key: true
  end
end
