require 'rails_helper'
include SelectListHelper



RSpec.describe SelectListHelper do

  describe 'user_select_list' do
    it 'should return a select list of users ordered by last name along with a blank option' do
      users = (1..5).map{fake_last_name}.sort.uniq.map{|last_name| FactoryGirl.create(:user, last_name: last_name)}
      expected__list = users.map{|user| [user.formal_name, user.id]}
      expected__list.unshift ['', -1]
      expect(users.user_select_list).to eq expected__list
    end
  end

  describe 'activity_select_list' do
    it 'should return a select list of activities order by title for a given creator with a blank and create new' do
      creator = FactoryGirl.create(:user)
      activities = (1..5).map{fake_title}.uniq.sort.map{|title| FactoryGirl.create(:activity, title: title, creator: creator)}
      expected_list = activities.map{|activity| [activity.title, activity.id]}
      expected_list.unshift ['', -1]
      expected_list.unshift ['Create New', 0]
      expect(activities.activity_select_list(creator)).to eq expected_list
    end
  end

end
