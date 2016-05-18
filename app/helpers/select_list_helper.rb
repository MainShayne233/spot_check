module SelectListHelper

  def user_select_list
    options = User.all.order(:last_name).map{|user| [user.formal_name, user.id]}
    options.unshift ['', -1]
  end

  def activity_select_list(creator)
    options = creator.activities.order(:title).map{|activity| [activity.title, activity.id]}
    options.unshift ['', -1]
    options.unshift ['Create New', 0]
  end

  def first_activity(creator_id)
    activity = Activity.where(creator_id: creator_id).first
    [activity.title, activity.id]
  end

end