class Spotcheck < ActiveRecord::Base

  belongs_to :checker, class_name: 'User'
  has_many :spots, dependent: :destroy

  validates :checker, presence: true
  validates :title, presence: true, uniqueness: {scope: :checker}

  def assignees
    self.spots.map {|spot| spot.assignee}
  end


end
