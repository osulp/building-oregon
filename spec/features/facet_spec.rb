require 'spec_helper'

describe "Facets" do
  before do
    Blacklight.solr.delete_by_query("*:*")
    Blacklight.solr.commit
  end
  context "When there is information in the database" do
    context "and the index page is visited" do
      before do
        loader = BuildingOregon::FixtureLoader.new("mock_data.json")
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
        visit root_path
      end
      it "should have no facets there" do
        expect(page).to_not have_selector(".facet-values")
      end
    end
  end
end
