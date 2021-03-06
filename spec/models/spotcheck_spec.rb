require 'rails_helper'

RSpec.describe Spotcheck, type: :model do

  describe 'validations' do


    it 'should have its necessary relationships' do
      ['checker'].each do |relation|
        spotcheck = FactoryGirl.build(:spotcheck, relation => nil)
        expect(spotcheck.save).to_not be
        spotcheck.send("#{relation}=", FactoryGirl.create(relation))
        expect(spotcheck.save).to be
      end
    end

    it 'should have its necessary attributes' do
      ['title'].each do |attr|
        spotcheck = FactoryGirl.build(:activity, attr => nil)
        expect(spotcheck.save).to_not be
        spotcheck.send("#{attr}=", send("fake_#{attr}"))
        expect(spotcheck.save).to be
      end
    end

    it 'should have a title' do
      spotcheck = FactoryGirl.create(:user).spotchecks.new
      expect(spotcheck.save).to_not be
      spotcheck.title= 'Support SW'
      expect(spotcheck.save).to be
    end
  end


  describe 'assignees' do
    it 'should return the assignees of all of its spots' do
      spotcheck = FactoryGirl.create(:spotcheck)
      assignees = 5.times.map {FactoryGirl.create(:user)}
      assignees.each {|assignee| FactoryGirl.create(:spot,
                                                    spotcheck: spotcheck,
                                                    assignee: assignee)}
      expect(spotcheck.assignees.sort).to eq assignees.sort
    end
  end

  describe 'spots_by_users' do
    it 'should return its spots sorted by user last names' do
      spotcheck = FactoryGirl.create(:spotcheck)
      users = (1..5).map{fake_last_name}.uniq.sort.map{|last_name| FactoryGirl.create(:user, last_name: last_name)}
      spots = users.map {|user| FactoryGirl.create(:spot, spotcheck: spotcheck, assignee: user)}
      expect(spotcheck.spots_by_users).to eq spots
    end
  end

  describe 'has_no_spots?' do
    it 'should return true if the spotcheck has no spots' do
      spotcheck = FactoryGirl.create(:spotcheck)
      expect(spotcheck.has_no_spots?).to be
    end

    it 'should return false otherwise' do
      spotcheck = FactoryGirl.create(:spotcheck)
      FactoryGirl.create(:spot, spotcheck: spotcheck)
      expect(spotcheck.has_no_spots?).to_not be
    end
  end

  describe 'generate_spreadsheet' do
    it 'create and return the path of a spotcheck spreadsheet' do
      spotcheck = FactoryGirl.create(:spotcheck)
      spot = FactoryGirl.create(:spot, spotcheck: spotcheck)
      spreadsheet = Spreadsheet.open spotcheck.generate_spreadsheet
      row = spreadsheet.worksheet(0).row(0).to_a
      expect(row).to eq ["Assignee:", "Activity:", "Hours Worked:",
                         "Hours Left:", "Work Accomplished:"]
      row = spreadsheet.worksheet(0).row(1).to_a
      expect(row).to eq [spot.assignee.formal_name, spot.activity.title,
                         spot.hours_worked, spot.activity.hours_left,
                         spot.work_accomplished]
    end
  end

  describe 'sortability' do
    it "should only return 'sortable' if the current_user is the checker" do
      checker = FactoryGirl.create(:user)
      assignee = FactoryGirl.create(:user)
      spotcheck = FactoryGirl.create(:spotcheck)
      3.times {FactoryGirl.create(:spot, spotcheck: spotcheck, assignee: assignee)}
      expect(spotcheck.sortability(assignee, checker)).to eq ''
      spotcheck.checker= checker
      expect(spotcheck.sortability(assignee, checker)).to eq 'sortable'
    end

    it "should only return 'sortable' if the spot has at least one neighboring spot" do
      checker = FactoryGirl.create(:user)
      assignee = FactoryGirl.create(:user)
      spotcheck = FactoryGirl.create(:spotcheck, checker: checker)
      FactoryGirl.create(:spot, spotcheck: spotcheck, assignee: assignee)
      expect(spotcheck.sortability(assignee, checker)).to eq ''
      FactoryGirl.create(:spot, spotcheck: spotcheck, assignee: assignee)
      expect(spotcheck.sortability(assignee, checker)).to eq 'sortable'
    end
  end

end
