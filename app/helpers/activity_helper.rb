module ActivityHelper

  def assignees_list(activity)
    activity.assignees.map{|assignee| assignee.formal_name}.sort.join(" | ")
  end


end