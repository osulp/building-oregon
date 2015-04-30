require 'spec_helper'

RSpec.describe GeoController do
  let(:loader) { BuildingOregon::FixtureLoader.new(json, solr) }
  let(:file) { File.read(Rails.root.join("lib/tasks/mock_data.json")) }
  let(:json) { JSON.parse(file) }
  let(:solr) { Blacklight.default_index.connection }
  render_views
  describe "#frame" do
    before do
      loader.load!
    end
    context "when given a frame" do
      it "should return an empty array if there's nothing nearby" do
        get :frame, :southwest => "0,0", :northeast => "2,2", :format => :json

        expect(json_response["features"]).to eq []
      end
      it "should return an array of documents if there's something nearby" do
        southwest = "#{json.first["desc_metadata__latitude_ssm"]},#{json.first["desc_metadata__longitude_ssm"]}"
        northeast = "#{json.first["desc_metadata__latitude_ssm"].to_i+10},#{json.first["desc_metadata__longitude_ssm"].to_i+10}"
        get :frame, :southwest => southwest, :northeast => northeast, :format => :json

        expect(json_response["features"].length).to eq 1
      end
    end
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end
