module BuildingOregon
  class FieldSanitizer
    attr_reader :field
    def initialize(field)
      @field = field.dup
    end

    def sanitize
      remove_metadata_tag
    end

    private

    def remove_metadata_tag
      @field.gsub!("desc_metadata__", "")
      remove_format
    end

    def remove_format
      format_list.each {|format| @field.gsub!(format, "")}
      @field
    end

    def format_list
      ["_ssim", "_sim", "_llsim", "_ssm", "label", "Display"]
    end
  end
end
