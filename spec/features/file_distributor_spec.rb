require 'spec_helper'

describe "File Distributor#path" do
  let (:pid) {"oregondigital:1234"}
  let(:fd) {BuildingOregon::FileDistributor.new(pid)}
  let(:url) {"http://oregondigital.library.oregonstate.edu/media/medium-images/4/3/oregondigital-1234.jpg"}
  context "When a File Destributor exists with a pid" do

    describe "#source_site=" do
      before do
        fd.source_site = "blah"
      end
      it "should allow for the setting of a source site" do
        expect(fd.source_site).to eq "blah"
      end
    end

    describe "#extension=" do
      before do
        fd.extension = "blah"
      end
      it "should allow for the setting of an extension" do
        expect(fd.extension).to eq "blah"
      end
    end

    before do
      fd.source_site="http://oregondigital.library.oregonstate.edu/"
      fd.extension=".jpg"
    end
    it "should generate a URI for a medium image from oregon digital" do
      expect(fd.path).to eq url
    end

    describe "#identifier" do
      it "should return the pid with all non-alphaneumerics replaced with hyphens" do
        expect(fd.identifier).to eq("oregondigital-1234")
      end
    end

    describe "#filename" do

      it "should return the identifier modified by #identifier with .jpg appended at the end" do
        expect(fd.filename).to eq(fd.identifier + ".jpg")
      end
    end

    describe "#bucket_path" do

      it "should return the last two characters of the pid in reverse delimited with /" do
        expect(fd.bucket_path).to eq "4/3/"
      end
    end
  end
end
