require 'spec_helper'

RSpec.describe BuildingOregon::KeyFilter do
  let(:filter) {described_class.new(simple_array) }
  let(:simple_array) {["stuff", "things", "banana", "yodawg"]}
  let(:exceptions) {["stuff", "things"]}
  let(:filtered_list) {["banana", "yodawg"]}
  let(:key) {"stuff"}
  describe "#exceptions_list" do
    it "should return an array of keys" do
      allow(filter).to receive(:exceptions_list).and_return(exceptions)
      expect(filter.exceptions_list).to eq exceptions
    end
  end

  describe "#filter_exceptions" do
    it "should filter out the exceptions described within the object" do
      allow(filter).to receive(:filter_exceptions).and_return(filtered_list)
      expect(filter.filter_exceptions).to eq filtered_list
    end
  end

  describe "#contained_in_exception_list" do
    it "should return a true of false depending on if a key is contained in exceptions" do
      allow(filter).to receive(:contained_in_exception_list).with(key).and_return(true)
      expect(filter.contained_in_exception_list(key)).to eq true
    end
  end

  context "When using the key filter" do
    before do
      filter.exceptions=exceptions
    end
    it "should take a list of keys and filter them based on exceptions" do
      expect(filter.call).to eq filtered_list
    end
  end
end
