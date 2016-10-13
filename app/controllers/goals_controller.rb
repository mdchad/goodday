class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  before_action :is_authenticated, except: [:index]
  helper_method :sort_column, :sort_direction
  before_action :search
  before_action :current_user
  # GET /goals
  def index
    @search = Goal.search(params[:q])
    @goals = @search.result(distinct: true).paginate(page: params[:page], per_page: 3).order(sort_column + " " + sort_direction)
    @q = Goal.ransack(params[:q])
    @events = @q.result(distinct: true)
    @pledge = Pledge.new
    @goal = Goal.where(id: params[:id])
    @id = params[:id]
  end
  # GET /goals/1
  def show
  end
  # GET /goals/:specialityid/new
  def new
    @goal = Goal.new
  end
  # GET /goals/1/edit
  def edit
  end
  # POST /goals
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id if current_user
    upload_file
    if @goal.save
      redirect_to goals_path, notice: 'Goal was successfully created.'
    else
      redirect_to goals_path, notice: 'Irsyad says no.'
    end
  end

  # PATCH/PUT /goals/1
  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: 'Goal was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /goals/1
  def destroy
    @goal.destroy
    redirect_to goals_url, notice: 'Goal was successfully destroyed.'
  end

  def upvote
    @goal = Goal.find(params[:id])
    @goal.upvote_by current_user
    puts "upvoted"
    render json: { goal: @goal.id, votesup: @goal.get_upvotes.size, votesdown: @goal.get_downvotes.size }
    # redirect_to :back
  end

  def downvote
    @goal = Goal.find(params[:id])
    @goal.downvote_by current_user
    render json: { goal: @goal.id, votesup: @goal.get_upvotes.size, votesdown: @goal.get_downvotes.size }
    # redirect_to :back
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
