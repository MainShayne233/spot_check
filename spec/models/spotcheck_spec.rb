require 'rails_helper'

RSpec.describe Spotcheck, type: :model do

  it 'should always have a checker' do
    spotcheck = Spotcheck.new()
    expect(spotcheck.save).to_not be
    spotcheck.checker = FactoryGirl.create(:user)
    expect(spotcheck.save).to be
  end

end
