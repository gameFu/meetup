class MeetUpsController < ApplicationController

  def index
    @meet_ups = MeetUp.all
    respond_to do |format|
      format.html
      format.json {
        render json: @meet_ups.as_json
      }
    end

  end

  def new
    @meet_up = MeetUp.new
  end

  def show
    @meet_up = MeetUp.includes(:comments).find(params[:id])
    @comment = Comment.new
    @comments = @meet_up.comments.order("created_at asc")
  end

  def create
    @meet_up = MeetUp.new(meet_up_params)
    @meet_up.user_id = current_user.id
    if @meet_up.save
      redirect_to meet_ups_url
    else
      render 'new'
    end
  end

  private
  def meet_up_params
    params.require(:meet_up).permit(:content)
  end

end
