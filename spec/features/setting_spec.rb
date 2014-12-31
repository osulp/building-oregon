require 'spec_helper'

describe "settings" do

  context "when logged in as an admin" do
    let(:user) {create(:user, :admin)}

    before do
      capybara_login(user) if user
      visit admin_index_path
    end

    context "and trying to view the current settings" do
      before do
        click_link "Setting Information"
      end

      context "when there are configured field types" do
        let(:setup) do
          Setting.stub(:default_settings).and_return({
            "text" => {
              "tag_attributes" => {
                "type" => "text"
              }
            }, "Copyright" => {}, "Title" => ""
          })
        end
        before do
          expect(page).to have_selector(".setting", :count => Setting.default_settings.length)
        end
        it "should use it" do
          expect(page).to have_selector("input[type=text]")
        end
      end
    end

    context 'when creating a new setting' do
      let(:setting){create(:setting, :setting_name => 'This', :value => 'that')}

      before do
        setting
        click_link "Setting Information"
      end

      it "should create a setting with the specified value" do
        expect(page).to have_content("This")
        expect(page).to have_content("that")
      end
    end
  end

end