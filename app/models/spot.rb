class Spot < ActiveRecord::Base

  belongs_to :activity
  belongs_to :spotcheck
  belongs_to :assignee, class_name: 'User'

  validates :activity, presence: true
  validates :spotcheck, presence: true
  validates :assignee, presence: true
  def title
    self.activity.title
  end

  def assigner
    self.spotcheck.checker.name
  end

end
