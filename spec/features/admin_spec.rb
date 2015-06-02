require 'spec_helper'

describe "admin" do
  let(:user) {create(:user, :admin)}
  context "when logged in as an admin" do
    before do
      capybara_login(user) if user
      visit admin_index_path
    end
    it "should display the admin panel" do
      expect(page).to have_link("Setting Information")
    end
    context "when on the settings page" do
      before do
        click_link "Setting Information"
      end
      it "should display the setting page" do
        expect(page).to have_content("Contact")
        expect(page).to have_content("About")
      end
      context "when using the WYSIWYG editor", :js => true do
        it "should have WYSIWYG editors" do
          expect(page).to have_selector(".mce-container")
        end
      end
      context "when filling the settings" do
        let(:id) { Setting.where(:setting_name => "About").first.id }
        before do
          within ".setting_number_#{id}" do
            fill_in "Value", :with => "about info"
            click_button "Update Setting"
          end
          click_link "About"
        end
        it "should display new about info on about page" do
          expect(page).to have_content("about info")
        end
      end
    end
  end
end
