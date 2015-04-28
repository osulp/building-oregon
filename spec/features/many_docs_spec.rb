require 'spec_helper'

describe "many documents" do
  context "When there is information in the database" do
    let(:loader) { BuildingOregon::FixtureLoader.new(json, solr) }
    let(:json) { build_documents }
    let(:solr) { Blacklight.default_index.connection }
    before do
      loader.load!
    end

    context "and the homepage is visited", :js => true do
      before do
        visit root_path
      end
      it "Should display icons on the map" do
        expect(page).to have_selector('.leaflet-marker-icon', :count => 11)
      end
    end
  end

  def build_documents
    docs = []
    11.times do |id|
      docs << {
        :id => "test#{id}",
        :reviewed_ssim => "true",
        :desc_metadata__set_sim => "http://oregondigital.org/resource/oregondigital:building-or",
        :desc_metadata__latitude_ssm => rand(45.596858),
        :desc_metadata__longitude_ssm => rand(-123.102949)
      }
    end
    docs
  end
end
