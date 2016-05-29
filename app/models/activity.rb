class Activity < ActiveRecord::Base

  validates :title, presence: true, uniqueness: {scope: :creator, case_sensitive: false}
  validates :creator, presence: true

  has_many :spots, dependent: :destroy
  belongs_to :creator, class_name: 'User'

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



end
