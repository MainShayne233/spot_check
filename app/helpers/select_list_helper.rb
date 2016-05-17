module SelectListHelper

  def user_select_list
    User.all.order(:last_name).map{|user| [user.formal_name, user.id]}
  end

  def activity_select_list(creator_id)
    options = Activity.where(creator_id: creator_id).map{|activity| [activity.title, activity.id]}
    options.unshift ''
    options.unshift ['Create New', 0]
  end

  def first_activity(creator_id)
    activity = Activity.where(creator_id: creator_id).first
    [activity.title, activity.id]
  end

end