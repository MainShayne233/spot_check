require 'rails_helper'

describe User do

  describe 'Validations' do

    it 'should have a unique email' do
      user = FactoryGirl.build(:user, email: nil)
      expect(user.save).to_not be
      user.email= 'foo@bar.com'
      expect(user.save).to be
      another_user = FactoryGirl.build(:user, email: user.email)
      expect(another_user.save).to_not be
    end

    it 'should have a first name' do
      user = FactoryGirl.build(:user, last_name: 'nomis', first_name: nil)
      expect(user.save).to_not be
      user.first_name= 'simon'
      expect(user.save).to be
    end

    it 'should have a last name' do
      user = FactoryGirl.build(:user, last_name: nil)
      expect(user.save).to_not be
      user.last_name= 'nomis'
      expect(user.save).to be
    end

    it 'should have a unique first and last name pair' do
      FactoryGirl.create(:user, first_name: 'Simon', last_name: 'Monis')
      user = FactoryGirl.build(:user, first_name: 'Simon', last_name: 'Monis')
      expect(user.save).to_not be
      user.first_name= 'Ian'
      expect(user.save).to be
      user.first_name= 'Simon'
      user.last_name= 'Johnson'
      expect(user.save).to be
    end

  end

  describe 'name' do
    it 'should return the formatted name of the user' do
      user = FactoryGirl.create(:user, first_name: 'Simon', last_name: 'Monis')
      expect(user.name).to eq 'Simon Monis'
    end
  end

  describe 'spots_from' do
    it 'should return all of the spots belonging to a specific spotcheck of the user' do
      user = FactoryGirl.create(:user)
      spotcheck = FactoryGirl.create(:spotcheck)
      spots = (0..5).map{FactoryGirl.create(:spot, assignee: user, spotcheck: spotcheck)}
      expect(user.spots_from(spotcheck).sort).to eq spots.sort
    end
  end

  describe 'capitalize_names' do
    it 'should capitalize the names of a user before saving it to the databse' do
      user = FactoryGirl.create(:user, first_name: 'simon', last_name: 'nomis')
      expect(user.first_name).to eq 'Simon'
      expect(user.last_name).to eq 'Nomis'
    end
  end

end
