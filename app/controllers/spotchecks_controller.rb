class SpotchecksController < ApplicationController

  def index
    @spotchecks = current_user.affiliated_spotchecks
    @spotcheck = current_user.spotchecks.new
  end

  def create
    @spotcheck = current_user.spotchecks.new(spotcheck_params)
    unless @spotcheck.save
      flash[:danger] = @spotcheck.errors.full_messages.first
    end
    redirect_to root_path
  end

  def show
    @spotcheck = Spotcheck.find(params[:id])
    @spot = Spot.new
  end

  def destroy
    @spotcheck = Spotcheck.find(params[:id])
    if @spotcheck.destroy
      redirect_to root_path
    end
  end


  private

  def spotcheck_params
    params.require(:spotcheck).permit(:id, :title)
  end


end