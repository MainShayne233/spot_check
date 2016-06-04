module SpotcheckHelper

  def spotcheck_delete_confirm
    {confirm: 'Are you sure you want to delete this spotcheck?'}
  end

  def sortable?(spotcheck, assignee)
    return '' unless [spotcheck.checker, assignee].include? current_user
    return '' unless spotcheck.spots.where(assignee_id: assignee.id).count > 1
    'sortable'
  end

end