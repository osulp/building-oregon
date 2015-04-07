require 'spec_helper'

describe "Facets" do
  let(:loader) { BuildingOregon::FixtureLoader.new(json, solr) }
  let(:file) { File.read(Rails.root.join("lib/tasks/mock_data.json")) }
  let(:json) { JSON.parse(file) }
  let(:solr) { Blacklight.solr }
  context "When there is information in the database" do
    context "and the index page is visited" do
      before do
        loader.load!
        visit root_path
      end
      it "should display the facets" do
        expect(page).to have_selector(".facet-values")
      end
      context "When a Facet is clicked on" do
        before do
          click_link "Abby Morrow, 2014"
          click_link "List"
        end
        it "Should display more of the facet's information" do
          within ".document-metadata" do
            expect(page).to have_content("description")
          end
        end
      end
    end
  end
  context "When there is no information in the database" do
    context "and the index page is visited" do
      before do
        solr.delete_by_query("*:*")
        solr.commit
        visit root_path
      end
      it "should have no facets there" do
        expect(page).to_not have_selector(".facet-values")
      end
    end
  end
end
