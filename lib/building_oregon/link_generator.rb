module BuildingOregon
  class LinkGenerator

    attr_reader :location_links, :locations

    def initialize(location_array)
      @location_array = location_array
      @location_links = []
      @locations = []
    end

    def extract_links
      @location_array.each do |location|
        if location.include?("$")
          location_index = location.index("$")
          @location_links << location.slice(location_index + 1 ..location.length)
          @locations << location.slice(0..location_index - 1)
        else
          @locations << location
        end
      end
      return self
    end
  end
end
