class AddReference < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :picture, :string
  end
end
