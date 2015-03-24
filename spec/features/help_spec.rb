require 'spec_helper'

describe 'Help Page' do

  before do
    visit root_path
  end

  context "when there are no settings configured" do
    context "and the help page is visited" do
      before do
        click_link "Help"
      end
      it 'should should show a blank page' do 
        expect(page).to have_content("")
      end
    end
  end

  context "when there are settings configured" do
    let(:setting){create(:setting, :setting_name => 'Help', :value => "Yo!")}
    before do
      setting
    end
    context "and the help page is visited" do
      before do
        click_link "Help"
      end
      it 'should display the configured settings' do 
        expect(page).to have_content("Yo!")
      end
    end
  end
end
