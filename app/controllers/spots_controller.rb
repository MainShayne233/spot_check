class SpotsController < ApplicationController

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      redirect_to "/spotchecks/#{@spot.spotcheck_id}"
    end
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.update(spot_params)
    respond_to do |format|
      format.json { render json: true}
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