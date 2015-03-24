require 'spec_helper'

describe "Show Page" do
  context "When on the index page" do
    before do
      loader = BuildingOregon::FixtureLoader.new("mock_data.json")
      loader.load!
      visit root_path
    end
    context "and routing to the show page" do
      before do
        click_link "Abby Morrow, 2014"
        click_link "List"
        within ".document" do
          click_link "Abby Morrow, 2014"
        end
      end
      it "should take you to the show page with information" do
        expect(page).to have_content("Description")
      end
    end
  end
end
