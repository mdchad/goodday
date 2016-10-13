class AlterColumnTableFieldname < ActiveRecord::Migration[5.0]
  def self.up
    change_table :goals do |t|
      t.change :deadline, :date
    end
  end
  def self.down
    change_table :goals do |t|
      t.change :deadline, :datetime
    end
  end
end
