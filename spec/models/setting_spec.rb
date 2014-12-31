require 'spec_helper'

describe Setting do
  it {should validate_presence_of(:setting_name)}
  it {should validate_uniqueness_of(:setting_name)}
end
