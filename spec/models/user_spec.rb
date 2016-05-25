require 'rails_helper'

describe User do

  describe 'Validations' do

    it 'should have its necessary attributes' do
      ['first_name', 'last_name'].each do |attr|
        user = FactoryGirl.build(:user, attr => nil)
        expect(user.save).to_not be
        user.send("#{attr}=", send("fake_#{attr}"))
        expect(user.save).to be
      end
    end

    it 'should have unique attributes' do
      ['email', 'name'].each do |attr|
        generated_attr = send("fake_#{attr}")
        FactoryGirl.create(:user, attr => generated_attr)
        user = FactoryGirl.build(:user, attr => generated_attr)
        expect(user.save).to_not be
        user.send("#{attr}=", send("fake_#{attr}"))
        expect(user.save).to be
      end
    end

  end

  describe 'name' do
    it 'should return the formatted name of the user' do
      user = FactoryGirl.create(:user, first_name: 'Simon', last_name: 'Monis')
      expect(user.name).to eq 'Simon Monis'
    end
  end

  describe 'name=' do
    it 'should set the first and last name of the user' do
      user = FactoryGirl.create(:user)
      user.name= 'Simon Nomis'
      expect(user.first_name).to eq 'Simon'
      expect(user.last_name).to eq 'Nomis'
      expect {user.name='Simon'}.to raise_error('Did not supply a full name, or supplied too many names.')
    end
  end

  describe 'formal_name' do
    it 'should return the formatted name of the user' do
      user = FactoryGirl.create(:user, first_name: 'Simon', last_name: 'Monis')
      expect(user.formal_name).to eq 'Monis, Simon'
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

  describe 'affiliated_spotchecks' do
    it 'should return the spotchecks the user is a part of or a checker of' do
      user = FactoryGirl.create(:user)
      owned_spotcheck = FactoryGirl.create(:spotcheck, checker: user)
      member_of_spotcheck = FactoryGirl.create(:spotcheck)
      FactoryGirl.create(:spot, spotcheck: member_of_spotcheck, assignee: user)
      expect(user.affiliated_spotchecks.sort).to eq [owned_spotcheck, member_of_spotcheck].sort
    end
  end

  describe 'capitalize_names' do
    it 'should capitalize the names of a user before saving it to the databse' do
      user = FactoryGirl.create(:user, first_name: 'simon', last_name: 'nomis')
      expect(user.first_name).to eq 'Simon'
      expect(user.last_name).to eq 'Nomis'
    end
  end

  describe 'total hours' do
    it 'should return a the total hours of an assignee for a given spotcheck' do
      assignee = FactoryGirl.create(:user)
      spotcheck = FactoryGirl.create(:spotcheck)
      durations = (1..5).map{rand(40)}
      durations.each {|hours_worked| FactoryGirl.create(:spot, spotcheck: spotcheck,
                                                           assignee: assignee,
                                                           hours_worked: hours_worked)}

      expect(assignee.total_hours(spotcheck)).to eq durations.reduce(:+)
    end
  end

  describe 'role_in' do
    it 'should return the role a user has given a specific spotcheck' do
      user = FactoryGirl.create(:user)
      checker_of = FactoryGirl.create(:spotcheck, checker: user)
      assignee_of = FactoryGirl.create(:spotcheck)
      FactoryGirl.create(:spot, assignee: user, spotcheck: assignee_of)
      no_role = FactoryGirl.create(:spotcheck)
      expect(user.role_in(checker_of)).to eq 'checker'
      expect(user.role_in(assignee_of)).to eq 'assignee'
      expect(user.role_in(no_role)).to eq 'no role'
    end
  end

  describe 'is_affiliated_with' do

    it 'should return true if the user is the assignee of the given spot' do
      assignee = FactoryGirl.create(:user)
      spot = FactoryGirl.create(:spot, assignee: assignee)
      expect(assignee.is_affiliated_with(spot)).to be
    end

    it "should return true if the user is the checker of the given spot's spotcheck" do
      checker = FactoryGirl.create(:user)
      spotcheck = FactoryGirl.create(:spotcheck, checker: checker)
      spot = FactoryGirl.create(:spot, spotcheck: spotcheck)
      expect(checker.is_affiliated_with(spot)).to be
    end

    it 'should return false otherwise' do
      user = FactoryGirl.create(:user)
      spot = FactoryGirl.create(:spot)
      expect(user.is_affiliated_with(spot)).to_not be
    end

  end

  describe 'is_assigner_of' do

    it "should return true if the user is the checker of the given spot's spotcheck" do
      checker = FactoryGirl.create(:user)
      spotcheck = FactoryGirl.create(:spotcheck, checker: checker)
      spot = FactoryGirl.create(:spot, spotcheck: spotcheck)
      expect(checker.is_assigner_of(spot)).to be
    end

    it 'should return false otherwise' do
      user = FactoryGirl.create(:user)
      spot = FactoryGirl.create(:spot)
      expect(user.is_assigner_of(spot)).to_not be
      spot = FactoryGirl.create(:spot, assignee: user)
      expect(user.is_assigner_of(spot)).to_not be
    end
  end

  


end
