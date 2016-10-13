class Beneficiary < ApplicationRecord
  has_many :goals, dependent: :nullify
  has_many :campaigns, dependent: :nullify
end
