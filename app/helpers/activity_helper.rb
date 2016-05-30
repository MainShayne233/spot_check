module ActivityHelper

  def assignees_list(activity)
    activity.assignees.map{|assignee| assignee.formal_name}.sort.join(" | ")
  end

  def activity_delete_confirm
    confirm_hash = {confirm: 'Are you sure you want to delete this activity?'}
    confirm_hash[:confirm] += " It will remove this activity from all users."
    confirm_hash
  end


end
