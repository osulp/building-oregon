require 'spec_helper'

RSpec.describe CatalogController do
  let(:loader) { BuildingOregon::FixtureLoader.new(json, solr) }
  let(:file) { File.read(Rails.root.join("lib/tasks/mock_data.json")) }
  let(:json) { JSON.parse(file) }
  let(:solr) { Blacklight.default_index.connection }
  describe "#index" do
    context "when there are documents" do
      before do
        loader.load!
        get :index
      end
      it "should return them" do
        expect(assigns(:document_list).length).to eq 2
      end
    end
    let(:document) do
      {:id => "good", :reviewed_ssim => "true", :desc_metadata__set_sim => "http://oregondigital.org/resource/oregondigital:building-or", :desc_metadata__latitude_teim => "9001", :desc_metadata__format_sim => "http://purl.org/NET/mediatypes/image/tiff"}
    end
    def bad_document(attributes={})
      document.merge({:id => "bad"}.merge(attributes))
    end
    it "should work" do
      solr.add(document)
      solr.commit
      get :index
      expect(assigns(:document_list).length).to eq 1
    end
    context "when there are unreviewed documents" do
      before do
        solr.add(document)
        solr.add(bad_document(:reviewed_ssim => "false"))
        solr.commit
        get :index
      end
      it "should not return them" do
        expect(assigns(:document_list).length).to eq 1
      end
    end
    context "when there are documents in the wrong collection" do
      before do
        solr.add(document)
        solr.add(bad_document(:desc_metadata__set_sim => "bad_set"))
        solr.commit
        get :index
      end
      it "should not return them" do
        expect(assigns(:document_list).length).to eq 1
      end
    end
    context "when there are documents without lat/longs" do
      before do
        solr.add(document)
        solr.add(bad_document(:desc_metadata__latitude_teim => nil))
        solr.commit
        get :index
      end
      it "should return the one with the lat/long" do
        expect(assigns(:document_list).length).to eq 1
      end
    end
    context "when there are documents that are non image ones" do
      before do
        solr.add(document)
        solr.add(bad_document(:desc_metadata__format_sim => "http://Blah.com"))
        solr.commit
        get :index
      end
      it "should return the one that is an image" do
        expect(assigns(:document_list).length).to eq 1
      end
    end
 
  end
end
