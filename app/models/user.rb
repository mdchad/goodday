class User < ApplicationRecord
  # CONSTANTS
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # MIXINS
  has_secure_password validations: false
  acts_as_voter

  # ASSOCIATIONS
  has_many :credit_cards, dependent: :nullify
  has_many :pledges, dependent: :nullify
  has_many :goals, dependent: :nullify
  has_many :volunteers, dependent: :nullify
  has_many :donations, dependent: :nullify
  has_many :campaigns, dependent: :nullify




  # VALIDATIONS
  validates :first_name,
    presence: true,
    length: { in: 3..50 }

  validates :family_name,
      length: { maximum: 50 }

  validates :email,
    presence: true,
    length: { maximum: 255 },
    uniqueness: {case_sensitive: false},
    format: VALID_EMAIL_REGEX

  validates :password, length: { in: 8..72 } , confirmation: true, :if => :password_needs_validating?

  # custom method to ensure we have atleast one admin user
  validate :atleast_one_admin

  # HOOKS
  before_save :downcase_fields

  # PUBLIC METHODS
  def name
    "#{first_name.titlecase} #{family_name.try(:titlecase)}"
  end
  def self.authenticate(params)
    User.find_by_email(params[:email]).try(:authenticate, params[:password])
  end

  # PRIVATE METHODS
  private

  def atleast_one_admin
    if is_admin == false && User.where(:is_admin => true).count < 2
      errors.add(:base, "must have at least 1 admin user")
    end
  end

  def password_needs_validating?
    if (new_record? && provider_id.blank?) || password.present?
      true
    else
      false
    end
  end

  def downcase_fields
    self.email = email.downcase
    self.first_name = first_name.downcase
    self.family_name = family_name.downcase unless family_name.blank?
  end
end
