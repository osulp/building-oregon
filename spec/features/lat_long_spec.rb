require 'spec_helper'

describe "Lat\Long configuration" do
  context "When there is information in the database" do
    let(:loader) { BuildingOregon::FixtureLoader.new(json, solr) }
    let(:file) { File.read(Rails.root.join("lib/tasks/mock_data.json")) }
    let(:json) { JSON.parse(file) }
    let(:solr) { Blacklight.default_index.connection }
    before do
      loader.load!
    end

    context "and the homepage is visited", :js => true do
      before do
        visit root_path
      end
      xit "Should display icons on the map" do
        expect(page).to have_selector('.leaflet-marker-icon')
      end
    end
  end
end
