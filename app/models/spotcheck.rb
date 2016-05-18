class Spotcheck < ActiveRecord::Base

  belongs_to :checker, class_name: 'User'
  has_many :spots, dependent: :destroy

  validates :checker, presence: true
  validates :title, presence: true, uniqueness: {scope: :checker}

  def assignees
    assignee_ids = self.spots.map {|spot| spot.assignee_id}
    User.where(id: assignee_ids)
  end

  def spots_by_users
    self.assignees.order(:last_name).map{|assignee| assignee.spots.where(spotcheck_id: self.id)}.flatten
  end


end
