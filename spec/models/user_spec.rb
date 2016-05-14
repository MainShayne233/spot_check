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
      FactoryGirl.create(:user, first_name: 'simon', last_name: 'monis')
      user = FactoryGirl.build(:user, first_name: 'simon', last_name: 'monis')
      expect(user.save).to_not be
      user.first_name= 'Ian'
      expect(user.save).to be
      user.first_name= 'simon'
      user.last_name= 'johnson'
      expect(user.save).to be
    end

  end

  describe 'name' do

    it 'should return the formatted name of the user' do
      user = FactoryGirl.create(:user, first_name: 'simon', last_name: 'monis')
      expect(user.name).to eq 'monis, simon'
    end

  end

end
