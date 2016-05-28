class Spotcheck < ActiveRecord::Base

  belongs_to :checker, class_name: 'User'
  has_many :spots, dependent: :destroy

  validates :checker, presence: true
  validates :title, presence: true, uniqueness: {scope: :checker, case_sensitive: false}

  def assignees
    assignee_ids = self.spots.map {|spot| spot.assignee_id}
    User.where(id: assignee_ids)
  end

  def spots_by_users
    self.assignees.order(:last_name).map{|assignee| assignee.spots.where(spotcheck_id: self.id)}.flatten
  end

  def has_no_spots?
    self.spots.blank?
  end


  def generate_spreadsheet
    titles_row = ['Assignee:', 'Activity:', 'Hours Worked:', 'Hours Left:', 'Work Accomplished:']

    workbook = Spreadsheet::Workbook.new

    workbook.create_worksheet name: self.title

    workbook.worksheet(0).insert_row(0, titles_row)

    self.spots_by_users.each_with_index do |spot, index|
      workbook.worksheet(0).insert_row(index + 1, spot.spreadsheet_row)
    end

    path = "tmp/#{self.title}_spotcheck_#{Time.now.strftime('%m-%e-%y_%I-%M-%S-%L')}.xls"

    workbook.write(path)

    path
  end


end
