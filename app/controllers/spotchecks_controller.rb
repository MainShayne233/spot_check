class SpotchecksController < ApplicationController

  def index

  end

  def new
    @spotcheck = current_user.spotchecks.new()
  end

  def create
    @spotcheck = current_user.spotchecks.new(spotcheck_params)
    if @spotcheck.save
      render 'index'
    end
  end

  def show
    @spotcheck = Spotcheck.find(params[:id])
  end


  private

  def spotcheck_params
    params.require(:spotcheck).permit(:id, :title)
  end

end