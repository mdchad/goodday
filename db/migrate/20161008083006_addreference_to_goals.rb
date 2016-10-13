class AddreferenceToGoals < ActiveRecord::Migration[5.0]
  def change
    add_reference :goals, :beneficiary, foreign_key: true
  end
end
