class Spot < ActiveRecord::Base

  belongs_to :activity
  belongs_to :spotcheck
  belongs_to :assignee, class_name: 'User'

  validates :activity, presence: true, uniqueness: {scope: [:assignee, :spotcheck]}
  validates :spotcheck, presence: true
  validates :assignee, presence: true

  before_create :row_order_set

  def title
    self.activity.title
  end

  def assigner
    self.spotcheck.checker.name
  end

  def reorder(position)
    if self.row_order > position
      affiliated_spots.order(:row_order).to_a[position..(self.row_order-1)].each {|spot| spot.update row_order: spot.row_order + 1}
    elsif self.row_order < position
      affiliated_spots.order(:row_order).to_a[(self.row_order+1)..position].each {|spot| spot.update row_order: spot.row_order - 1}
    end
    self.row_order = position
  end

  def spreadsheet_row
    row = []
    row << self.assignee.formal_name
    row << self.activity.title
    row << self.hours_worked
    row << self.activity.hours_left
    row << self.work_accomplished
    row
  end

  def row_order_set
    self.row_order = self.affiliated_spots.count
  end

  def affiliated_spots
    Spot.where(spotcheck_id: self.spotcheck_id).where(assignee_id: self.assignee_id)
  end

end
