class SpotchecksController < ApplicationController

  def index
    @spotchecks = current_user.affiliated_spotchecks
    @spotcheck = current_user.spotchecks.new
  end

  def create
    @spotcheck = current_user.spotchecks.new(spotcheck_params)
    @spotcheck.save
    respond_to do |format|
      format.json {render json: @spotcheck.errors.full_messages.first}
    end
  end

  def show
    @spotcheck = Spotcheck.find(params[:id])
    @spot = Spot.new
    @activity = Activity.new
  end

  def destroy
    @spotcheck = Spotcheck.find(params[:id])
    if @spotcheck.destroy
      redirect_to root_path
    end
  end

  def download
    @spotcheck = Spotcheck.find(params[:id])
    send_file @spotcheck.generate_spreadsheet
  end


  private

  def spotcheck_params
    params.require(:spotcheck).permit(:id, :title)
  end


end