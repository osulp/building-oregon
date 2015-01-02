require 'spec_helper'

describe "index page" do

  let(:user) {create(:user, :admin)}

  context "when on the index page" do
    before do
      visit root_path
    end
    it "should say building oregon" do
      expect(page).to have_content("Building Oregon")
    end

    it "should have a link to the about page" do
      expect(page).to have_link('About Us')
    end

    context "logged in as admin and the admin panel link is clicked" do
      before do
        capybara_login(user) if user
        visit root_path
        click_link 'Admin Panel'
      end

      it 'should take you to the admin panel page' do
        expect(page).to have_content('Administration Dashboard')
      end
    end

    context 'not logged in as admin and the admin panel is accessed' do
      before do
        visit admin_index_path
      end

      it 'should not allow access' do
        expect(page).to have_content('Only admin can access')
      end
    end
  end
end
