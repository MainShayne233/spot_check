require 'rails_helper'

RSpec.describe Activity, type: :model do

  describe 'validations' do

    it 'should have its necessary relationships' do
      ['creator'].each do |relation|
        activity = FactoryGirl.build(:activity, relation => nil)
        expect(activity.save).to_not be
        activity.send("#{relation}=", FactoryGirl.create(relation))
        expect(activity.save).to be
      end
    end

    it 'should have its necessary attributes' do
      ['title'].each do |attr|
        activity = FactoryGirl.build(:activity, attr => nil)
        expect(activity.save).to_not be
        activity.send("#{attr}=", send("fake_#{attr}"))
        expect(activity.save).to be
      end
    end

    it 'should have unique attributes within scope of creator' do
      user = FactoryGirl.create(:user)
      ['title'].each do |attr|
        generated_attr = send("fake_#{attr}")
        FactoryGirl.create(:activity, creator: user, attr => generated_attr)
        activity = FactoryGirl.build(:activity, creator: user, attr => generated_attr)
        expect(activity.save).to_not be
        activity.send("#{attr}=", send("fake_#{attr}"))
        expect(activity.save).to be
      end
    end

  end

  describe 'dependencies' do

    it 'should be deleted if one of its dependencies is deleted' do
      [:creator].each do |relation|
        dependency = FactoryGirl.create(relation)
        activity = FactoryGirl.create(:activity, relation => dependency)
        another_activity = FactoryGirl.create(:activity, relation => dependency)
        dependency.destroy
        expect(Activity.exists?(activity.id)).to_not be
        expect(Activity.exists?(another_activity.id)).to_not be
      end
    end
  end

  describe 'alphabetical index' do

    it "'should return the index of the activity for a given creator's activites in alphabetical order" do
      creator = FactoryGirl.create(:user)
      activities = (1..5).map {fake_title}.uniq.sort.map{|title| FactoryGirl.create(:activity, title: title, creator: creator)}
      rand_index = rand(activities.count)
      selected_activity = activities[rand_index]
      expect(selected_activity.alphabetical_index(creator)).to eq rand_index
    end

  end

end
