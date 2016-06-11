class ActivitiesController < ApplicationController

  def index
    @activities = current_user.activities.order(:row_order)
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

  def update
    @activity = Activity.find(params[:id])
    @activity.update(activity_params)
    respond_to do |format|
      format.json { render json: {}}
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    if @activity.destroy
      redirect_to activities_path
    end
  end

  def update_row_order
    @activity = Activity.find(activity_params[:id])
    @activity.reorder(activity_params[:row_order_position].to_i)
    render nothing: true
  end

  private

  def activity_params
    params.require(:activity).permit(:id, :title, :hours_left, :row_order_position)
  end

end
