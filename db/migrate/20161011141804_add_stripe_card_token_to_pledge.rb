class AddStripeCardTokenToPledge < ActiveRecord::Migration[5.0]
  def change
    add_column :pledges, :card_token, :string
    add_column :pledges, :email, :string
  end
end
