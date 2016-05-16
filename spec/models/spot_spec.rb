require 'rails_helper'

RSpec.describe Spot, type: :model do

  describe 'validations do' do
    it 'should have an assignee' do
      spot = Spot.new(
          activity_id: FactoryGirl.create(:activity).id,
          spotcheck_id: FactoryGirl.create(:spotcheck).id
      )
      expect(spot.save).to_not be
      user = FactoryGirl.create(:user)
      spot.assignee= user
      expect(spot.save).to be
    end

    it 'should have an activity' do
      spot = Spot.new(
          assignee_id: FactoryGirl.create(:user).id,
          spotcheck_id: FactoryGirl.create(:spotcheck).id
      )
      expect(spot.save).to_not be
      activity = FactoryGirl.create(:activity)
      spot.activity= activity
      expect(spot.save).to be
    end

    it 'should have a spotcheck' do
      spot = Spot.new(
          activity_id: FactoryGirl.create(:activity).id,
          assignee_id: FactoryGirl.create(:user).id
      )
      expect(spot.save).to_not be
      spotcheck = FactoryGirl.create(:spotcheck)
      spot.spotcheck= spotcheck
      expect(spot.save).to be
    end
  end

  describe 'title' do
    it "should return the title of the spot's activity" do
      activity = FactoryGirl.create(:activity)
      spot = FactoryGirl.create(:spot, activity: activity)
      expect(spot.title).to eq activity.title
    end
  end

  describe 'assigner' do
    it "should return the name of the spot's assigner" do
      assigner = FactoryGirl.create(:user, first_name: 'simon', last_name: 'nomis')
      spotcheck = FactoryGirl.create(:spotcheck, checker: assigner)
      spot = FactoryGirl.create(:spot, spotcheck: spotcheck)
      expect(spot.assigner).to eq assigner.name
    end
  end



end
