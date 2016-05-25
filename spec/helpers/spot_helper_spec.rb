require 'rails_helper'
include SpotHelper

RSpec.describe SpotHelper do

  describe 'spot_delete_confirm' do
    it 'should return the correct javascipt confirm hash' do
      expect(spot_delete_confirm).to eq(confirm: 'Are you sure you want to delete this spot?')
    end
  end

end
