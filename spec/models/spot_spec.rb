require 'rails_helper'

RSpec.describe Spot, type: :model do

  it 'should belong to an activity, a spotcheck, and a user' do
    spot = Spot.new()
    expect(spot.save).to_not be
    spot.spotcheck= FactoryGirl.create(:spotcheck)
    expect(spot.save).to_not be
    spot.activity= FactoryGirl.create(:activity)
    expect(spot.save).to_not be
    spot.user= FactoryGirl.create(:user)
    expect(spot.save).to be
  end

  describe 'title' do

    it "should return the title of the spot's activity" do
      activity = FactoryGirl.create(:activity)
      spot = FactoryGirl.create(:spot, activity: activity)
      expect(spot.title).to eq activity.title
    end

  end

end
