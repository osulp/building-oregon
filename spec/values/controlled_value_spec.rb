require 'spec_helper'

RSpec.describe ControlledValue do
  subject { described_class.new(value) }
  describe "#to_s" do
    let(:result) { subject.to_s }
    context "when given a CV string" do
      let(:value) { "Test Place$http://test.test" }
      it "just be the value" do
        expect(result).to eq "Test Place"
      end
    end
    context "when given a normal label" do
      let(:value) { "Stuff And Things" }
      it "should just return the value" do
        expect(result).to eq value
      end
    end
  end
end
