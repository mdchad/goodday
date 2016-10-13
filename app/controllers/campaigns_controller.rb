class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :is_authenticated
  before_action :is_authenticated_admin, except: [:index, :show]
  before_action :search

  # GET /campaigns
  def index
    @campaigns = Campaign.all
    @volunteer = Volunteer.new
    @donation = Donation.new
    @campaign = Campaign.where(id: params[:id])

    @id = params[:id]

  end
  # GET /campaigns/1
  def show
      @campaign = Campaign.find(params[:id])
      @new_comment = Comment.build_from(@campaign, current_user.id, "")
  end
  # GET /campaigns/:specialityid/new
  def new
    @campaign = Campaign.new
  end
  # GET /campaigns/1/edit
  def edit
  end
  # POST /campaigns
  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.user_id = current_user.id if current_user
    upload_file
    if @campaign.save
      redirect_to campaigns_path, notice: 'Campaign was successfully created.'
    else
      redirect_to campaigns_path, notice: 'Irsyad says no.'
    end
  end

  # PATCH/PUT /campaigns/1
  def update
    if @campaign.update(campaign_params)
      redirect_to @campaign, notice: 'Campaign was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /campaigns/1
  def destroy
    @campaign.destroy
    redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:title, :description, :deadline, :beneficiary_id, :target_amount, :user_id, :beneficiary_id, :id)
    end

    def upload_file
      # upload file if specified in params
      if params[:campaign][:picture].present?
        if @campaign.valid?
          # only save if the campaign is valid to improve performance
          uploaded_file = params[:campaign][:picture].path
          cloudnary_file = Cloudinary::Uploader.upload(uploaded_file)
          # save the reference to the old file and assign the new file to the instance
          @old_file = @campaign.picture
          @campaign.picture = cloudnary_file['public_id']
        end
        #remove image from the hash so we don't accidently use it
        params[:campaign].delete :picture
      end
    end

    def delete_old_file old_file = nil
      # was a file id passed in, if not check in an instance variable
      file_to_del = old_file || @old_file
      # if we had a previous file then delete it
      Cloudinary::Uploader.destroy(file_to_del, :invalidate => true) unless file_to_del.blank?
    end

end
