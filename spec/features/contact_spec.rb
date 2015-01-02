require 'spec_helper'

describe 'Contact Page' do

  before do
    visit root_path
  end

  context "when there are no settings configured" do
    context "and the contact page is visited" do
      before do
        click_link "Contact Us"
      end
      it 'should say there are no settings configured' do 
        expect(page).to have_content("No settings are configured.")
      end
    end
  end

  context "when there are settings configured" do
    let(:setting){create(:setting, :setting_name => 'Contact', :value => "Yo!")}
    before do
      setting
    end
    context "and the contact page is visited" do
      before do
        click_link "Contact Us"
      end
      it 'should say there are no settings configured' do 
        expect(page).to have_content("Yo!")
      end
    end
  end
end