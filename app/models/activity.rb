class Activity < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true

  has_many :spots

end
