require 'spec_helper'

describe "Show Page" do
  let(:loader) { BuildingOregon::FixtureLoader.new(json, solr) }
  let(:file) { File.read(Rails.root.join("lib/tasks/mock_data.json")) }
  let(:json) { JSON.parse(file) }
  let(:solr) { Blacklight.solr }
  context "When on the index page" do
    before do
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
        expect(page).to have_content("title")
      end
    end
  end
end
