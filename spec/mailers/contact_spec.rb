require 'spec_helper'

describe "Contact Us" do
  
  let(:mailer_deliveries) {ActionMailer::Base.deliveries}
  let(:configured_email) {"blah@blah.com"}
  let(:default_email) { "margaret.mellinger@oregonstate.edu" }

  context "when viewing the contact us page" do
    before do
      visit root_path 
      click_link "Contact Us"
    end

    it "should display the proper forms" do
      expect(page).to have_field("Message")
      expect(page).to have_field("Email") 
    end

    context "when an email has been configured in the settings" do
      let(:setting){create(:setting, :setting_name => 'Contact', :value => configured_email)}

      before do
        setting
      end
      
      context "and the form is filled out correctly" do
        before do
          correct_form
        end

        it "should send the email to the configured email" do
          successful_email_send(configured_email)
        end
      end
      context "and the form is filled out incorrectly" do
        before do
          incorrect_form
        end

        it "should error and keep the information in the field" do
          unsuccessful_email_send
        end
      end
    end
    context "when an email has not been configured in the settings" do
      let(:setting){create(:setting, :setting_name => 'Contact', :value => '')}

      before do
        setting
      end
      
      context "and the form is filled out correctly" do
        before do
          correct_form
        end

        it "should send the email to the default email" do
          successful_email_send(default_email)
        end
      end
      context "and the form is filled out incorrectly" do
        before do
          incorrect_form
        end

        it "should error and keep the information in the field" do
          unsuccessful_email_send
        end
      end
    end
  end
end

def correct_form
  fill_in "Email", :with => "test@email.com"
  fill_in "Message", :with => "test contact info"
  click_button "Submit"
end

def incorrect_form
  fill_in "Message", :with => "test contact info"
  click_button "Submit"
end

def successful_email_send(email)
  expect(page).to have_content("Thank you for contacting us!")
  expect(mailer_deliveries.length).to eq 1
  expect(mailer_deliveries.first.body).to have_content("test contact info") 
  expect(mailer_deliveries.first.to.first).to eq email
end

def unsuccessful_email_send
  expect(page).to have_content("Please enter an email address and try again")
  expect(mailer_deliveries.length).to eq 0
  expect(page).to have_field("Message", :with => "test contact info") 
end
