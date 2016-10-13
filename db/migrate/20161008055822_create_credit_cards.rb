class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.references :user, foreign_key: true
      t.string :card_number

      t.timestamps
    end
  end
end
