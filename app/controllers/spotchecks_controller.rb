class SpotchecksController < ApplicationController

  def index
    @spotcheck = current_user.spotchecks.new
  end

  def create
    @spotcheck = current_user.spotchecks.new(spotcheck_params)
    if @spotcheck.save
      render 'index'
    else
      @errors = @spotcheck.errors.full_messages.first
      respond_to do |format|
        format.js { render 'spotchecks/failed_spotcheck_errors.coffee.erb'}
      end
    end
  end

  def show
    @spotcheck = Spotcheck.find(params[:id])
    @spot = Spot.new()
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