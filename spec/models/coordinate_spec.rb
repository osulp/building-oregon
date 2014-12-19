require 'spec_helper'

describe Coordinate do
  it{should validate_presence_of(:solr_id)}
  it{should validate_presence_of(:lat)}
  it{should validate_presence_of(:long)}
end
