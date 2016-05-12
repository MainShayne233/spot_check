require 'rails_helper'

RSpec.describe Activity, type: :model do

  it 'should always be unique and have a title' do
    expect(Activity.new().save).to_not be
    expect(Activity.new(title: 'Activity Title').save).to be
    expect(Activity.new(title: 'Activity Title').save).to_not be
  end



end
