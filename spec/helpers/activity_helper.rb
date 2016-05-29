require 'rails_helper'
include ActivityHelper

RSpec.describe ActivityHelper do

  describe 'assignee_list' do
    it 'should return a string of the assignees seperate by a |' do
      activity = FactoryGirl.create(:activity)
      assignees = (1..5).map{FactoryGirl.create(:spot, activity: activity).assignee.formal_name}.sort
      expect(activity.assignee_list).to eq assignees.join(" | ")
    end
  end

end
