require 'spec_helper'

describe "Link Generator" do
  let(:location_array) {["Place >> Place$www.blah.com"]}
  let(:sans_link) {["Place >> Place"]}
  let(:both){["Place >> Place$www.blah.com", "Place2 >> Place2"]}
  let(:lg) {BuildingOregon::LinkGenerator.new(location_array)}
  let(:lg2) {BuildingOregon::LinkGenerator.new(sans_link)}
  let(:lg3) {BuildingOregon::LinkGenerator.new(both)}
  describe "#Extract Links" do
    context "Extracting links when the array has a link" do
    
      before do
        @link_gen = lg.extract_links
      end
      it "should parse an array for a url and a title for a link" do
        expect(@link_gen.locations).to eq ["Place >> Place"]
        expect(@link_gen.location_links).to eq ["www.blah.com"]
      end
    end
    context "Extracting links when the array does not have a link" do
      before do
        @link_gen = lg2.extract_links
      end
      it "should parse an array for a title and have the url array be blank" do
        expect(@link_gen.locations).to eq ["Place >> Place"]
        expect(@link_gen.location_links).to eq []
      end
    end
    context "Extracting links when the array has both a link and a non link place" do
      before do
        @link_gen = lg3.extract_links
      end
      it "should parse the array for 2 titles and a url" do
        expect(@link_gen.locations).to eq ["Place >> Place", "Place2 >> Place2"]
        expect(@link_gen.location_links).to eq ["www.blah.com"]
      end
    end
  end
end
