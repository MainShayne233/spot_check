module SelectListHelper

  def user_select_list
    User.all.map{|user| [user.name, user.id]}
  end

  def activity_select_list(creator_id)
    Activity.where(creator_id: creator_id).map{|activity| [activity.title, activity.id]}
  end

end