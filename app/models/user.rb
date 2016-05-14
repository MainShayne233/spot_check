class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :email, uniqueness: true
  validates :first_name, presence: true, uniqueness: {scope: :last_name}
  validates :last_name, presence: true, uniqueness: {scope: :first_name}


  has_many :spots, foreign_key:  :assignee_id
  has_many :spotchecks, foreign_key: :checker_id
  has_many :activities, foreign_key: :creator_id

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def name
    "#{self.last_name}, #{self.first_name}"
  end
end
