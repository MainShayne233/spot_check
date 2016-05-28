class ActivitiesController < ApplicationController

  def show
    @activities = current_user.activities.order(:title)
  end

  def create
    @activity = current_user.activities.new(activity_params)
    if @activity.save
      data = {index: @activity.alphabetical_index(current_user), activities: activity_select_list(current_user)}
    else
      data = @activity.errors.full_messages.first
    end
    respond_to do |format|
      format.json {render json: data}
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:title)
  end

end