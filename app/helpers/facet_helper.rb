module FacetHelper
  def controlled_label(label)
    BuildingOregon::ControlledValue.new(label).to_s
  end

  def controlled_index_label(label)
    label[:value].map do |value|
      BuildingOregon::ControlledValue.new(value).to_s
    end
  end
 

end
