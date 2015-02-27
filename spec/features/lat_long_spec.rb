require 'spec_helper'
require 'rake'

describe "Lat\Long configuration" do
  context "When there is information in the database" do
    before do
      loader = BuildingOregon::FixtureLoader.new("mock_data.json")
      loader.load!
    end

    context "and the homepage is visited", :js => true do
      before do
        visit root_path
      end
      it "Should display icons on the map" do
        expect(page).to have_selector('.leaflet-marker-icon')
      end
    end
  end
end