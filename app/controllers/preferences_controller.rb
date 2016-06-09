class PreferencesController < ApplicationController

  def update
    current_user.preferences.update_attributes preferences_params
    respond_to do |format|
      format.json { render json: {}}
    end
  end

  def get
    respond_to do |format|
      format.json { render json: current_user.preferences}
    end
  end


  private

  def preferences_params
    params.require(:preferences).permit(:show_all_spots)
  end

end