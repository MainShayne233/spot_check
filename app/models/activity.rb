class Activity < ActiveRecord::Base

  validates :title, presence: true, uniqueness: {scope: :creator, case_sensitive: false}
  validates :creator, presence: true

  has_many :spots, dependent: :destroy
  belongs_to :creator, class_name: 'User'

  before_create :row_order_set


  def alphabetical_index(creator)
    Activity.where(creator_id: creator.id).order(:title).pluck(:id).to_a.index(self.id)
  end

  def assignees
    self.spots.map{|spot| spot.assignee}.uniq
  end

  def spotchecks
    self.spots.map{|spot| spot.spotcheck}.uniq
  end

  def total_hours_worked
    total = self.spots.map{|spot| spot.hours_worked}.reduce(:+)
    total ||= 0
  end

  def reorder(position)
    if self.row_order > position
      self.creator.activities.order(:row_order).to_a[position..(self.row_order-1)].each {|activity| activity.update row_order: activity.row_order + 1}
    elsif self.row_order < position
      self.creator.activities.order(:row_order).to_a[(self.row_order+1)..position].each {|activity| activity.update row_order: activity.row_order - 1}
    end
    self.update row_order: position
  end

  def row_order_set
    self.row_order = self.creator.activities.count
  end


end
