class BeneficiariesController < ApplicationController
  before_action :is_authenticated, except: [:index]
  before_action :search
  before_action :current_user

  def index
    @beneficiaries = Beneficiary.all
  end
end
