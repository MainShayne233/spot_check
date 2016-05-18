require 'rails_helper'
include SpotcheckHelper

RSpec.describe SpotcheckHelper do

  describe 'spotcheck_delete_confirm' do
    it 'should return the correct javascipt confirm hash' do
      expect(spotcheck_delete_confirm).to eq(confirm: 'Are you sure you want to delete this spotcheck?')
    end
  end

end
