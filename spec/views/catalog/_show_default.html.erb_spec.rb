require 'spec_helper'

RSpec.describe "catalog/_show_default.html.erb" do
  let(:config) { CatalogController.blacklight_config }
  before do
    allow(view).to receive(:blacklight_config).and_return(config)
  end
  
  describe "label display" do
    let(:document) do
      SolrDocument.new(
        :id => "stuff",
        'desc_metadata__location_label_ssm' => location_label
      )
    end
    before do
      allow(view).to receive(:document).and_return(document)
      render
    end
    context "with a non-CV" do
      let(:location_label) { "Stuff and Things" }
      it "should display it as is" do
        expect(rendered).to have_content "Stuff and Things"
      end
    end
    context "with a CV" do
      let(:location_label) { "Stuff and Things$http://test.org" }
      it "should just display the label" do
        expect(rendered).to include BuildingOregon::ControlledValue.new(location_label).to_s
      end
    end
  end


end
