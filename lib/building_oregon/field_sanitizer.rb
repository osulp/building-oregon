module BuildingOregon
  class FieldSanitizer
    attr_reader :field
    def initialize(field)
      @field = field.dup
    end

    def sanitize
      remove_metadata_tag
      map_multiword_field
      @field
    end

    private

    def remove_metadata_tag
      @field.gsub!("desc_metadata__", "")
      remove_format
    end

    def map_multiword_field
      @new_field = multi_word_fields[@field] if multi_word_fields.key?(@field) 
      @field.gsub!(@field, @new_field) unless @new_field.nil?
    end

    def remove_format
      format_list.each {|format| @field.gsub!(format, "")}
    end

    def multi_word_fields
      {
        "workType" => "Work Type",
        "streetAddress" => "Street Address",
        "itemLocator" => "Item Locator",
        "isPartOf" => "Is part of",
        "rightsHolder" => "Rights Holder",
        "stylePeriod" => "Style Period",
        "viewDate" => "View Date",
      }
    end

    def format_list
      ["_ssim", "_sim", "_llsim", "_ssm", "label", "Display"]
    end
  end
end
