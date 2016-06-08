class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  before_save :capitalize_names
  after_create :create_preferences
  after_initialize :set_default_role, :if => :new_record?

  validates :email, uniqueness: true
  validates :first_name, presence: true, uniqueness: {scope: :last_name}
  validates :last_name, presence: true, uniqueness: {scope: :first_name}


  has_many :spots, foreign_key:  :assignee_id, dependent: :destroy
  has_many :spotchecks, foreign_key: :checker_id, dependent: :destroy
  has_many :activities, foreign_key: :creator_id, dependent: :destroy
  has_one :preferences, dependent: :destroy

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def name=(name)
    raise 'Did not supply a full name, or supplied too many names.' if name.split(' ').count != 2
    self.update(first_name: name.split(' ').first, last_name: name.split(' ').last)
  end

  def formal_name
    "#{self.last_name}, #{self.first_name}"
  end

  def spots_from(spotcheck)
    self.spots.where(spotcheck_id: spotcheck.id).order(:row_order)
  end

  def affiliated_spotchecks
    spotcheck_ids = self.spots.pluck(:spotcheck_id).concat self.spotchecks.pluck(:id)
    Spotcheck.where(id: spotcheck_ids.uniq).order(:title)
  end

  def total_hours(spotcheck)
    self.spots.where(spotcheck_id: spotcheck.id).map{|spot| spot.hours_worked}.reduce(:+)
  end

  def is_affiliated_with(spot)
    spot.spotcheck.checker == self or spot.assignee == self
  end

  def is_assigner_of(spot)
    spot.spotcheck.checker == self
  end

  def is_checker_of(spotcheck)
    spotcheck.checker == self
  end

  def role_in(spotcheck)
    return 'checker' if spotcheck.checker == self
    return 'assignee' if affiliated_spotchecks.include? spotcheck
    'no role'
  end

  private

  def create_preferences
    preferences = Preferences.create(user_id: id)
  end

  def capitalize_names
    self.first_name= self.first_name.titleize
    self.last_name= self.last_name.titleize
  end

end
