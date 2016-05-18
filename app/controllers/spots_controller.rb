class SpotsController < ApplicationController

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      redirect_to "/spotchecks/#{@spot.spotcheck_id}"
    end
  end

  def update
    byebug
    @spot = Spot.find(params[:id])
    @spot.update(spot_params)
  end


  private

  def spot_params
    params.require(:spot).permit(:assignee_id, :activity_id, :spotcheck_id)
  end

end