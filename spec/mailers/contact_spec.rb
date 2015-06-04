require 'spec_helper'

describe "Contact Us" do
  
  before do
    visit root_path
  end

  it "should have a link to the contact us page" do
    expect(page).to have_content("Contact Us")
  end

  context "when viewing the contact us page" do
    before do
      click_link "Contact Us"
    end
    it "should display the contact info" do
      expect(page).to have_content("Contact Us")
      expect(page).to have_field("Message")
    end
  end
  context "when contacting us" do
    context "when inputing an email" do
      before do
        visit contact_us_path
        fill_in "Email", :with => "test@email.com"
        fill_in "Message", :with => "test contact info"
        click_button "Submit"
      end
      it "should send an email" do
        expect(page).to have_content("Thank you for contacting us!")
        expect(ActionMailer::Base.deliveries.length).to eq 1
        expect(ActionMailer::Base.deliveries.first.body.raw_source).to have_content("test contact info")
      end
    end
    context "when not inputing an email" do
      before do
        visit contact_us_path
        fill_in "Message", :with => "test message"
        click_button "Submit"
      end
      it "should cause an error to occur" do
        expect(page).to have_content("Please enter an email address and try again")
        expect(ActionMailer::Base.deliveries.length).to eq 0
      end
      it "should keep the entered message" do
        expect(page).to have_field("Message", :with => "test message")
      end
    end
  end
end
