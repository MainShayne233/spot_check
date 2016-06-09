class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,
                                                       :last_name,
                                                       :email,
                                                       :password,
                                                       :password_confirmation])
  end

  def activity_select_list(creator_id)
    options = Activity.where(creator_id: creator_id).order(:title).to_a
    options.map!{|activity| [activity.title, activity.id]}
    options.unshift ['', -1]
    options.unshift ['Create New', 0]
  end

end
