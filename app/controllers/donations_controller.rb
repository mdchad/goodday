class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]
  before_action :is_authenticated, except: [:index]
  # GET /donation
  def index
    @donations = Donation.all
  end
  # GET /donation/1
  def show
  end
  # GET /donation/:specialityid/new
  def new
    @donation = Donation.new
    @campaigns = Campaign.where(id: params[:id])
    @id = params[:id]
  end
  # POST /donation
  def create
    @donation = Donation.new(donation_params)
    @donation.user_id = current_user.id if current_user
    if @donation.save
      redirect_to campaigns_path, notice: 'donation was successfully created.'
    else
      @campaigns = Campaign.where(id: @donation.campaign.id)
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_donation
    @donation = Donation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def donation_params
    params.require(:donation).permit(:amount, :campaign_id)
  end

end
