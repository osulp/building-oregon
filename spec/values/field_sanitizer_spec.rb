require 'spec_helper'

RSpec.describe BuildingOregon::FieldSanitizer do
  let(:field) { "desc_metadata__creatorDisplay_llsim" }
  let(:sanitizer) { described_class.new(field) }

  context "#to_s" do
    before do
      sanitizer
    end
    context "when given an indexed field" do
      it "should return a properly sanitized field" do
        expect(sanitizer.sanitize).to eq "creator"
      end
    end

    context "When given a normal string" do
      let(:sanitizer) {described_class.new("Yodawg")}
      it "should return the string" do
        expect(sanitizer.sanitize).to eq "Yodawg"
      end
    end
  end
end
