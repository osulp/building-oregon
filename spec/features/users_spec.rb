require 'spec_helper'

describe "users" do
  let(:user) {}
  context "when not logged in" do
    before do
      visit root_path
    end
    it "should have a link to log in" do
      expect(page).to have_link("Login")
    end
    it "should not have links to admin and saved searches" do
      expect(page).to_not have_link("Admin Panel")
      expect(page).to_not have_link("Saved Searches")
    end
    context "when creating an account" do
      before do
        click_link "Login"
        click_link "Sign up"
        fill_in "Email", :with => "user@specs.com"
        fill_in "Password", :with => "password"
        fill_in "Password confirmation", :with => "password"
        click_button "Sign up"
      end
      it "should create a new user and redirect" do
        expect(page).to have_content("Welcome! You have signed up successfully.")
        expect(User.last.email).to eq "user@specs.com"
      end
    end
  end
  context "when logged in as a non-admin" do
    let(:user) {create(:user)}
    before do
      capybara_login(user) if user
      visit root_path
    end
    it "should have links to log out" do
      expect(page).to have_link("Log Out")
    end
    it "should not have links to admin page" do
      expect(page).to_not have_link("Admin Panel")
    end
  end
  context "when logged in as an admin" do
    let(:user) {create(:user, :admin)}
    before do
      capybara_login(user) if user
      visit root_path
    end
    it "should link to the admin panel" do
      expect(page).to have_link("Admin Panel")
    end
  end
end
