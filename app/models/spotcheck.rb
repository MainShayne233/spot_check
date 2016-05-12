class Spotcheck < ActiveRecord::Base

  belongs_to :checker, class_name: 'User'
  has_many :spots

  validates :checker, presence: true
  validates :title, presence: true, uniqueness: true


end
