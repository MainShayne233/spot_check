module SpotcheckHelper

  def spotcheck_delete_confirm
    {confirm: 'Are you sure you want to delete this spotcheck?'}
  end

  def spots_by_users(spotcheck)
    spotcheck.assignees.order(:last_name).map{|assignee| assignee.spots.where(spotcheck_id: spotcheck)}.flatten
  end

end