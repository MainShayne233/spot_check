require 'rails_helper'

RSpec.describe Activity, type: :model do

  describe 'validations' do
    it 'should have a unique title' do
      user = FactoryGirl.create(:user)
      activity = user.activities.new
      expect(activity.save).to_not be
      activity.title= 'Activity Title'
      expect(activity.save).to be
      another_activity = user.activities.new(title: activity.title)
      expect(another_activity.save).to_not be
    end

    it 'should have a creator' do
      activity = Activity.new(title: 'Activity title')
      expect(activity.save).to_not be
      user = FactoryGirl.create(:user)
      activity.creator= user
      expect(activity.save).to be
    end
  end



end
