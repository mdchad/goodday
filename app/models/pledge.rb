class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :goal
  validates :amount, presence: true
  validate :pledges_total
  def process_payment
    customer = Stripe::Customer.create email: email,
                                       card: card_token

    Stripe::Charge.create customer: customer.id,
                          amount: (self.amount * 100).round,
                          description: user.name,
                          currency: 'sgd'
  end
  private
  def pledges_total
    @diff = goal.target_amount - goal.pledges_total
    if @diff < self.amount
      self.errors.add(:amount, "Do not pledge more than #{@diff}")
    end
  end
end
