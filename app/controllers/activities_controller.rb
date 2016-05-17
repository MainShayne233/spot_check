class ActivitiesController < ApplicationController

  def new
    @activity = current_user.activities.new(activity_params)
    if @activity.save
      respond_to do |format|
        format.json {render json: {id: @activity.id, title: @activity.title, count: current_user.activities.count}}
      end
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:title)
  end

end