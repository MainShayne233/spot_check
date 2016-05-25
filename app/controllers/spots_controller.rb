class SpotsController < ApplicationController

  def create
    @spot = Spot.new(spot_params)
    @spot.save
    respond_to do |format|
      format.json {render json: @spot.errors.full_messages.first}
    end
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.update(spot_params)
    respond_to do |format|
      format.json { render json: @spot.assignee.total_hours(@spot.spotcheck)}
    end
  end


  private

  def spot_params
    params.require(:spot).permit(:assignee_id,
                                 :activity_id,
                                 :spotcheck_id,
                                 :hours_worked,
                                 :hours_left,
                                 :work_accomplished)
  end

end