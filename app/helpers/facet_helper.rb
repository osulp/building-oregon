module FacetHelper
  def controlled_label(label)
    BuildingOregon::ControlledValue.new(label).to_s
  end

  def controlled_index_label(label)
    @value_array = []
    label[:value].each do |value|
      @value_array.append(BuildingOregon::ControlledValue.new(value).to_s)
    end
    @value_array
  end
 

end
