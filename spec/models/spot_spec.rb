require 'rails_helper'

RSpec.describe Spot, type: :model do

  describe 'validations do' do

    it 'should have its necessary relationships' do
      ['assignee', 'activity', 'spotcheck'].each do |relation|
        spot = FactoryGirl.build(:spot, relation => nil)
        expect(spot.save).to_not be
        spot.send("#{relation}=", FactoryGirl.create(relation))
        expect(spot.save).to be
      end
    end

  end


  describe 'dependencies' do

    it 'should be deleted if one of its dependencies is deleted' do
      [:spotcheck, :activity, :assignee].each do |relation|
        dependency = FactoryGirl.create(relation)
        spot = FactoryGirl.create(:spot, relation => dependency)
        another_spot = FactoryGirl.create(:spot, relation => dependency)
        dependency.destroy
        expect(Spot.exists?(spot.id)).to_not be
        expect(Spot.exists?(another_spot.id)).to_not be
      end
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
