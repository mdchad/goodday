class VolunteersController < ApplicationController
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]
  before_action :is_authenticated, except: [:index]
  before_action :search
  # GET /action
  def index
    @volunteers = Volunteer.all
  end
  # GET /volunteer/1
  def show
  end
  # GET /volunteer/:specialityid/new
  def new
    @volunteer = Volunteer.new
    @campaigns = Campaign.where(id: params[:id])
    @id = params[:id]
  end
  # POST /volunteer
  def create
    # puts params[:volunteer][:campaign_id]
    if Volunteer.exists?(user_id: current_user.id, campaign_id: params[:volunteer][:campaign_id])
      redirect_to campaigns_path
    else
      @volunteer = Volunteer.new(volunteer_params)
      @volunteer.user_id = current_user.id if current_user
      if @volunteer.save
        redirect_to campaigns_path
      else
        @campaigns = Campaign.where(id: @volunteer.campaign.id)
        render :new
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between volunteers.
  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def volunteer_params
    params.require(:volunteer).permit(:name, :campaign_id, :quantity)
  end

end
