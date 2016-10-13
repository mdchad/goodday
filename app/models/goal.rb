class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :beneficiary
  has_many :pledges, dependent: :nullify
  def pledges_total
    pledges.sum(:amount)
  end
  acts_as_votable
end
