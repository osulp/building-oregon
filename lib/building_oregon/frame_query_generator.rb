module BuildingOregon
  class FrameQueryGenerator
    attr_reader :southwest, :northeast
    def initialize(southwest, northeast)
      @southwest = southwest
      @northeast = northeast
    end
  
    def to_s
      "#{field}:[#{southwest} TO #{northeast}]"
    end

    private

    def field
      "desc_metadata__coordinates_llsim"
    end
  end
end
