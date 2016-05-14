require 'rails_helper'

RSpec.describe Spotcheck, type: :model do

  describe 'validations' do
    it 'should have a checker' do
      spotcheck = Spotcheck.new(title: 'Support SW')
      expect(spotcheck.save).to_not be
      spotcheck.checker= FactoryGirl.create(:user)
      expect(spotcheck.save).to be
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





end
