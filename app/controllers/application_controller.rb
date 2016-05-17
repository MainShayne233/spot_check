class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!


  def activity_select_list(creator_id)
    options = Activity.where(creator_id: creator_id).order(:title).map{|activity| [activity.title, activity.id]}
    options.unshift ['', -1]
    options.unshift ['Create New', 0]
  end

end
