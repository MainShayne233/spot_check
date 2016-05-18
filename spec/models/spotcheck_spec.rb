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
end
