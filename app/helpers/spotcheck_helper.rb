module SpotcheckHelper

  def spotcheck_delete_confirm
    {confirm: 'Are you sure you want to delete this spotcheck?'}
  end

  def sortable?(spotcheck, assignee)
    return 'sortable' if [spotcheck.checker, assignee].include? current_user
    ''
  end

end