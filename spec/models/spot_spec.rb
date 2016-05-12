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

end
