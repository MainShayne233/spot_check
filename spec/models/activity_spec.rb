require 'rails_helper'

RSpec.describe Activity, type: :model do

  describe 'validations do' do

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

end
