class Campaign < ApplicationRecord
  acts_as_commentable
  belongs_to :user
  belongs_to :beneficiary
  has_many :volunteers, dependent: :nullify
  has_many :donations, dependent: :nullify
  has_many :comments, dependent: :nullify
  def donations_total
    donations.sum(:amount)
  end
  def volunteers_total
    volunteers.sum(:quantity)
  end
end
