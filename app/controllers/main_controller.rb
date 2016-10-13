class MainController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  before_action :is_authenticated, except: [:index]
  helper_method :sort_column, :sort_direction
  before_action :search
  before_action :current_user
  before_action :search

  def index
    @search = Goal.search(params[:q])
    @goals = @search.result(distinct: true).paginate(page: params[:page], per_page: 3).order(sort_column + " " + sort_direction)
    @q = Goal.ransack(params[:q])
    @events = @q.result(distinct: true)
    @pledge = Pledge.new
    @goal = Goal.where(id: params[:id])
    @id = params[:id]
    @campaigns = Campaign.all
    @volunteer = Volunteer.new
    @donation = Donation.new
    @campaign = Campaign.where(id: params[:id])

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:title, :description, :target_amount, :penalty_amount, :deadline, :user_id, :is_goal_validated, :beneficiary_id)
    end

    def upload_file
      # upload file if specified in params
      if params[:goal][:picture].present?
        if @goal.valid?
          # only save if the goal is valid to improve performance
          uploaded_file = params[:goal][:picture].path
          cloudnary_file = Cloudinary::Uploader.upload(uploaded_file)
          # save the reference to the old file and assign the new file to the instance
          @old_file = @goal.picture
          @goal.picture = cloudnary_file['public_id']
        end
        #remove image from the hash so we don't accidently use it
        params[:goal].delete :picture
      end
    end

    def delete_old_file old_file = nil
      # was a file id passed in, if not check in an instance variable
      file_to_del = old_file || @old_file
      # if we had a previous file then delete it
      Cloudinary::Uploader.destroy(file_to_del, :invalidate => true) unless file_to_del.blank?
    end
    def sort_column
      Goal.column_names.include?(params[:sort]) ? params[:sort] : "title"
      # params[:sort]
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
