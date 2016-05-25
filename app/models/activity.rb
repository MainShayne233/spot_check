class Activity < ActiveRecord::Base

  validates :title, presence: true, uniqueness: {scope: :creator, case_sensitive: false}
  validates :creator, presence: true

  has_many :spots, dependent: :destroy
  belongs_to :creator, class_name: 'User'


  def alphabetical_index(creator)
    Activity.where(creator_id: creator.id).order(:title).pluck(:id).to_a.index(self.id)
  end

end

