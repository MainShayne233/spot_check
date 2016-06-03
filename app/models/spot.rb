class Spot < ActiveRecord::Base

  include RankedModel
  ranks :row_order

  belongs_to :activity
  belongs_to :spotcheck
  belongs_to :assignee, class_name: 'User'

  validates :activity, presence: true, uniqueness: {scope: [:assignee, :spotcheck]}
  validates :spotcheck, presence: true
  validates :assignee, presence: true

  def title
    self.activity.title
  end

  def assigner
    self.spotcheck.checker.name
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


  private



end
