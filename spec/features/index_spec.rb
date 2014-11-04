require 'spec_helper'

describe "index page" do
  context "when on the index page" do
    before do
      visit root_path
    end
    it "should say building oregon" do
      expect(page).to have_content("Building Oregon")
    end
  end
end
