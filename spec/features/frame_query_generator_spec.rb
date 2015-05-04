require 'spec_helper'

describe BuildingOregon::FrameQueryGenerator do
  let(:queryGen) {described_class.new(sw, ne) } 
  let(:sw) { -45.1234567 }
  let(:ne) { 123.1234567 }

  describe "#to_s" do
    it "should return a solr query for a specific field and a range" do
      expect(queryGen.to_s).to eq "desc_metadata__coordinates_llsim:[#{sw} TO #{ne}]"
    end
  end
end
