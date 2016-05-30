require 'rails_helper'
include ActivityHelper

RSpec.describe ActivityHelper do

  describe 'assignee_list' do
    it 'should return a string of the assignees seperate by a |' do
      activity = FactoryGirl.create(:activity)
      assignees = (1..5).map{FactoryGirl.create(:spot, activity: activity).assignee.formal_name}.sort
      expect(assignees_list(activity)).to eq assignees.join(" | ")
    end
  end

  describe 'activity_delete_confirm' do
    it 'should return the proper javascript confirm hash' do
      expect(activity_delete_confirm).to eq(
      confirm: 'Are you sure you want to delete this activity? It will remove this activity from all users.'
      )
    end
  end


end
