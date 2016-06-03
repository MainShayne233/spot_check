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

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    @spotcheck = Spotcheck.find(@spot.spotcheck.id)
    redirect_to @spotcheck
  end

  def update_row_order
    @spot = Spot.find(spot_params[:id])
    @spot.row_order = spot_params[:row_order]
    @spot.save

    render nothing: true
  end


  private

  def spot_params
    params.require(:spot).permit(:assignee_id,
                                 :activity_id,
                                 :spotcheck_id,
                                 :hours_worked,
                                 :hours_left,
                                 :work_accomplished,
                                 :row_order)
  end

end