require 'spec_helper'

RSpec.describe 'coordinates' do
  let(:user) {create(:user, :admin)}

  context 'when on the Administration Dashboard' do
    before do
      capybara_login(user) if user
      visit admin_index_path
    end

    context 'and Coordinate Object Information is clicked' do
      before do
        click_link 'Coordinate Object Information'
      end

      it 'should take you to the index page for Coordinate Objects' do
        pending 'waiting for coordinate objects to be merged with master'
      end
    end
  end
end