class ActivitiesController < ApplicationController

  def new
    @activity = current_user.activities.new(activity_params)
    if @activity.save
      respond_to do |format|
        format.json {render json: {index: @activity.alphabetical_index(current_user),
                                   activities: activity_select_list(current_user.id)}}
      end
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:title)
  end

end