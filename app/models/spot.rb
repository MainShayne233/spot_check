class Spot < ActiveRecord::Base

  belongs_to :activity
  belongs_to :spotcheck
  belongs_to :user

  validates :activity, presence: true
  validates :spotcheck, presence: true
  validates :user, presence: true

end
