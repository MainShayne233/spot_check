class Activity < ActiveRecord::Base

  validates :title, presence: true, uniqueness: {scope: :creator}
  validates :creator, presence: true

  has_many :spots
  belongs_to :creator, class_name: 'User'

end
