require 'spec_helper'

describe "FixtureLoader" do
  context "#load!" do
    let(:loader) { BuildingOregon::FixtureLoader.new(json, solr) }
    let(:file) { File.read(Rails.root.join("lib/tasks/mock_data.json")) }
    let(:json) { JSON.parse(file) }
    let(:solr) { Blacklight.solr }
    before do
      loader.load!
    end
      

    it "should inject information into the solr index" do
      expect(solr.get('select', :params => {:q => "*:*" }).length).to eq 3
    end
  end
end
