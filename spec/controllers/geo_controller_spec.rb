require 'spec_helper'

RSpec.describe GeoController do
  let(:loader) { BuildingOregon::FixtureLoader.new(json, solr) }
  let(:file) { File.read(Rails.root.join("lib/tasks/mock_data.json")) }
  let(:json) { JSON.parse(file) }
  let(:solr) { Blacklight.default_index.connection }
  render_views
  describe "#nearby" do
    before do
      loader.load!
    end
    context "when given coordinates to query" do
      it "should return an empty array if there's nothing nearby" do
        get :nearby, :latitude => "80", :longitude => "120", :format => :json

        expect(json_response["features"]).to eq []
      end
      it "should return an array of documents if there's something nearby" do
        get :nearby, :latitude => json.first["desc_metadata__latitude_ssm"], :longitude => json.first["desc_metadata__longitude_ssm"], :distance => 1, :format => :json

        expect(json_response["features"].length).to eq 1
      end
      it "should return documents according to distance" do
        get :nearby, :latitude => json.first["desc_metadata__latitude_ssm"], :longitude => json.first["desc_metadata__longitude_ssm"], :distance => 100000, :format => :json

        expect(json_response["features"].length).to eq 2
      end
    end
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end
