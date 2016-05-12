require 'rails_helper'

RSpec.describe Spotcheck, type: :model do

  it 'should have a checker and a unique title' do
    spotcheck = Spotcheck.new()
    expect(spotcheck.save).to_not be
    spotcheck.checker = FactoryGirl.create(:user)
    expect(spotcheck.save).to_not be
    spotcheck.title = 'Spotcheck title'
    expect(spotcheck.save).to be
    another_spotcheck = Spotcheck.new()
    another_spotcheck.checker = spotcheck.checker
    another_spotcheck.title= spotcheck.title
    expect(another_spotcheck.save).to_not be
    another_spotcheck.title= 'Another spotcheck title'
    expect(another_spotcheck.save).to be
  end



end
