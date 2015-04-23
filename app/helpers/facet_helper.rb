module FacetHelper
  def controlled_label(label)
    BuildingOregon::ControlledValue.new(label).to_s
  end

end
