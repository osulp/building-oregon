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
    context "when there are unreviewed documents" do
      before do
        solr.add({:id => "bad_doc", :reviewed_ssim => "false", :desc_metadata__set_ssm => "http://oregondigital.org/resource/oregondigital:building-or"})
        solr.commit
        get :index
      end
      it "should not return them" do
        expect(assigns(:document_list).length).to eq 0
      end
    end
    context "when there are documents in the wrong collection" do
      before do
        solr.add({:id => "bad_doc", :reviewed_ssim => "true", :desc_metadata__set_ssm => "http://oregondigital.org/resource/oregondigital:building-or"})
        solr.commit
        get :index
      end
      it "should not return them" do
        expect(assigns(:document_list).length).to eq 0
      end
    end
  end
end
