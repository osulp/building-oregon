require 'spec_helper'

describe 'about us' do
  
  context "When visiting the about us page" do
    before do
      visit about_index_path
    end
    
    context "and no about setting is configured" do
      it "should show a default message" do
        expect(page).to have_content("No 'About Us' setting is configured.")
      end
    end

    context "and about settings are configured" do
      let(:setting){create(:setting, :setting_name => "About", :value => "Hello")}

      before do
        setting
        visit about_index_path
      end

      it "should display that setting information" do
        expect(page).to have_content("Hello")
      end
    end
  end

end